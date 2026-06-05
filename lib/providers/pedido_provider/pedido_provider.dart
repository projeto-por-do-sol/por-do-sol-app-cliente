import 'dart:convert';

import 'package:client_app/data/services/pedido_service.dart';
import 'package:client_app/providers/carrinho_provider/carrinho_provider.dart';
import 'package:client_app/src/shared/models/adicionaisItem.dart';
import 'package:client_app/src/shared/models/item_carrinho.dart';
import 'package:client_app/src/shared/models/pedidos_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'pedido_provider.g.dart';

@Riverpod(keepAlive: true)
class PedidoNotifier extends _$PedidoNotifier {
  final _uuid = const Uuid();
  @override
  FutureOr<List<PedidosModel>> build() async {
    final dadosDB = await PedidoService.instance.listarPedidos();

    if (dadosDB.isEmpty) return [];

    final Map<String, List<ItemCarrinho>> itensAgrupados = {};
    final Map<String, QuiosqueCarrinho> quiosquesPorPedido = {};
    final Map<String, String> statusPorPedido = {};
    final Map<String, String> codigoPorPedido = {};
    final Map<String, String> horaPorPedido = {};

    for (var linha in dadosDB) {
      final idPedido = linha['idPedido'] as String;

      final listIngredientes = (jsonDecode(linha['ingredientes'] as String) as List).cast<String>();

      final listMapAdicionais = jsonDecode(linha['adicionais'] as String) as List;
      final listAdicionais = listMapAdicionais.map((adicionalJson) {
        return AdicionaisItem.fromMap(adicionalJson as Map<String, dynamic>);
      }).toList();

      final item = ItemCarrinho(
        idProduto: linha['idProduto'] as String,
        idQuiosque: linha['idQuiosque'] as String,
        nomeItem: linha['nomeItem'] as String,
        valorTotal: (linha['valorTotal'] as int),
        qtdeItem: linha['qtdeItem'] as int,
        ingredientes: listIngredientes,
        adicionais: listAdicionais,
      );

      itensAgrupados.putIfAbsent(idPedido, () => []).add(item);

      quiosquesPorPedido.putIfAbsent(
        idPedido,
            () => QuiosqueCarrinho(
          idQuiosque: linha['idQuiosque'] as String,
          nomeQuiosque: linha['nomeQuiosque'] as String,
          imgBannerQuiosque: linha['imgBannerQuiosque'] as String,
        ),
      );
      statusPorPedido.putIfAbsent(idPedido, () => linha['status'] as String);

      codigoPorPedido.putIfAbsent(idPedido, () => linha['codigoPedido'] as String);

      horaPorPedido.putIfAbsent(idPedido, () => linha['horaPedido'] as String);
    }

    final listPedidosSalvos = itensAgrupados.keys.map((idPedido) {
      return PedidosModel(
        idPedido: idPedido,
        codigoPedido: codigoPorPedido[idPedido]!,
        quiosque: quiosquesPorPedido[idPedido]!,
        itens: itensAgrupados[idPedido]!,
        status: statusPorPedido[idPedido]!,
        horaPedido: horaPorPedido[idPedido]!,
      );
    }).toList();

    return listPedidosSalvos;
  }

  Future<bool> criarPedido() async {
    final dados = ref.read(carrinhoProvider);
    if (dados.isEmpty) return false;

    try {
      final novosPedidos = <PedidosModel>[];

      final codigoBase = _uuid.v4().replaceAll('-', '').substring(0, 4).toUpperCase();

      for (var entry in dados.entries) {
        final quiosque = entry.key;
        final itens = entry.value;

        final idPedidoUnico = _uuid.v4();

        final pedido = PedidosModel(
          idPedido: idPedidoUnico,
          codigoPedido: codigoBase,
          quiosque: quiosque,
          itens: itens,
          status: "Esperando o quiosque aceitar",
          horaPedido: DateTime.now().toIso8601String(),
        );

        await mandarPedidoParaOBanco(pedido);
        novosPedidos.add(pedido);
      }

      ref.invalidateSelf();

      ref.read(carrinhoProvider.notifier).limparCarrinho();
      return true;
    } catch (e) {
      print("Erro ao criar pedido: $e");
      return false;
    }
  }


  Future<void> mandarPedidoParaOBanco(PedidosModel pedido) async {
    for (var item in pedido.itens) {
      final Map<String, dynamic> novoItem = {
        'idPedido': pedido.idPedido,
        'idProduto': item.idProduto,
        'idQuiosque': item.idQuiosque,
        'codigoPedido': pedido.codigoPedido,
        'nomeQuiosque': pedido.quiosque.nomeQuiosque,
        'imgBannerQuiosque': pedido.quiosque.imgBannerQuiosque,
        'nomeItem': item.nomeItem,
        'valorTotal': item.valorTotal,
        'ingredientes': jsonEncode(item.ingredientes),
        'adicionais': jsonEncode(item.adicionais),
        'qtdeItem': item.qtdeItem,
        'status': pedido.status,
        'horaPedido': pedido.horaPedido,
      };

      int idResultado = await PedidoService.instance.inserirItem(novoItem);

      if (idResultado < 0) {
        throw Exception("Falha ao inserir o item no banco local.");
      }
    }
  }

  void alterarStatus(String idPedido, String novoStatus) async {
    await PedidoService.instance.atualizarStatus(idPedido, novoStatus);

    if (state.hasValue) {
      state = AsyncData(
        state.value!.map((pedido) {
          if (pedido.idPedido == idPedido) {
            if (novoStatus == 'Finalizado'){
              apagarPedidoPorIdPedido(idPedido);
            }
            return PedidosModel(
              idPedido: pedido.idPedido,
              codigoPedido: pedido.codigoPedido,
              quiosque: pedido.quiosque,
              itens: pedido.itens,
              status: novoStatus,
              horaPedido: pedido.horaPedido,
            );
          }
          return pedido;
        }).toList(),
      );
    }
  }

  void apagarPedidos() async {
    state = const AsyncData([]);
    await PedidoService.instance.deletarTodosPedidos();
  }

  void apagarPedidoPorIdPedido(String idPedido) async {
    await PedidoService.instance.deletarPedidoPorId(idPedido);
    ref.invalidateSelf();
  }

  /// Busca um pedido no back-end (usado quando ele não está no banco local).
  Future<PedidosModel?> buscarPedidoNoBackend(String idPedido) =>
      PedidoService.instance.buscarPedidoNoBackend(idPedido);

  void finalizarTodosPedidos() async {
    await PedidoService.instance.finalizarTodosPedidos();
    if (state.hasValue) {
      state = AsyncData(
        state.value!
            .map((p) => PedidosModel(
                  idPedido: p.idPedido,
                  codigoPedido: p.codigoPedido,
                  quiosque: p.quiosque,
                  itens: p.itens,
                  status: 'Finalizado',
                  horaPedido: p.horaPedido,
                ))
            .toList(),
      );
    }
  }
}