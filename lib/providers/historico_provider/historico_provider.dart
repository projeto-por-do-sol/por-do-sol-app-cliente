import 'dart:convert';

import 'package:client_app/data/services/pedido_service.dart';
import 'package:client_app/src/shared/models/adicionaisItem.dart';
import 'package:client_app/src/shared/models/item_carrinho.dart';
import 'package:client_app/src/shared/models/pedidos_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final historicoProvider =
    AsyncNotifierProvider<HistoricoNotifier, List<PedidosModel>>(
      HistoricoNotifier.new,
    );

class HistoricoNotifier extends AsyncNotifier<List<PedidosModel>> {
  @override
  Future<List<PedidosModel>> build() async {
    return _carregarHistorico();
  }

  Future<List<PedidosModel>> _carregarHistorico() async {
    final dadosDB = await PedidoService.instance.listarPedidos();
    if (dadosDB.isEmpty) return [];

    final Map<String, List<ItemCarrinho>> itensAgrupados = {};
    final Map<String, QuiosqueCarrinho> quiosquesPorPedido = {};
    final Map<String, String> statusPorPedido = {};
    final Map<String, String> codigoPorPedido = {};
    final Map<String, String> horaPorPedido = {};

    for (var linha in dadosDB) {
      final idPedido = linha['idPedido'] as String;

      final listIngredientes =
          (jsonDecode(linha['ingredientes'] as String) as List).cast<String>();

      final listMapAdicionais =
          jsonDecode(linha['adicionais'] as String) as List;
      final listAdicionais =
          listMapAdicionais
              .map(
                (adicionalJson) =>
                    AdicionaisItem.fromMap(adicionalJson as Map<String, dynamic>),
              )
              .toList();

      final item = ItemCarrinho(
        idProduto: linha['idProduto'] as String,
        idQuiosque: linha['idQuiosque'] as String,
        nomeItem: linha['nomeItem'] as String,
        valorTotal: linha['valorTotal'] as int,
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
      codigoPorPedido.putIfAbsent(
        idPedido,
        () => linha['codigoPedido'] as String,
      );
      horaPorPedido.putIfAbsent(idPedido, () => linha['horaPedido'] as String);
    }

    return itensAgrupados.keys.map((idPedido) {
      return PedidosModel(
        idPedido: idPedido,
        codigoPedido: codigoPorPedido[idPedido]!,
        quiosque: quiosquesPorPedido[idPedido]!,
        itens: itensAgrupados[idPedido]!,
        status: statusPorPedido[idPedido]!,
        horaPedido: horaPorPedido[idPedido]!,
      );
    }).toList();
  }

  void refresh() => ref.invalidateSelf();
}
