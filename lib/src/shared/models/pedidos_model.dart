import 'package:client_app/src/shared/models/adicionaisItem.dart';
import 'package:client_app/src/shared/models/item_carrinho.dart';

class PedidosModel {
  final String idPedido;
  final String codigoPedido;
  final QuiosqueCarrinho quiosque;
  final List<ItemCarrinho> itens;
  String status;
  String horaPedido;
  String? motivoCancelamento;

  PedidosModel({
    required this.idPedido,
    required this.codigoPedido,
    required this.quiosque,
    required this.itens,
    required this.status,
    required this.horaPedido,
    this.motivoCancelamento,
  });

  /// Cria um pedido a partir do JSON retornado pelo back-end.
  ///
  /// Formato esperado (ajuste os nomes dos campos conforme a API do Spring):
  /// {
  ///   "idPedido": "...", "codigoPedido": "A1B2",
  ///   "status": "Cancelado pelo quiosque", "horaPedido": "2026-06-05T...",
  ///   "motivoCancelamento": "...",
  ///   "quiosque": { "idQuiosque": "...", "nomeQuiosque": "...", "imgBannerQuiosque": "..." },
  ///   "itens": [ { "idProduto": "...", "idQuiosque": "...", "nomeItem": "...",
  ///               "valorTotal": 1500, "qtdeItem": 1,
  ///               "ingredientes": ["..."], "adicionais": [{"nome": "...", "preco": 200}] } ]
  /// }
  factory PedidosModel.fromJson(Map<String, dynamic> json) {
    final quiosqueJson = json['quiosque'] as Map<String, dynamic>;
    final itensJson = (json['itens'] as List?) ?? const [];

    return PedidosModel(
      idPedido: json['idPedido'] as String,
      codigoPedido: json['codigoPedido'] as String,
      status: json['status'] as String,
      horaPedido: json['horaPedido'] as String,
      motivoCancelamento: json['motivoCancelamento'] as String?,
      quiosque: QuiosqueCarrinho(
        idQuiosque: quiosqueJson['idQuiosque'] as String,
        nomeQuiosque: quiosqueJson['nomeQuiosque'] as String,
        imgBannerQuiosque: quiosqueJson['imgBannerQuiosque'] as String?,
      ),
      itens: itensJson.map((itemJson) {
        final item = itemJson as Map<String, dynamic>;
        final adicionais = (item['adicionais'] as List?) ?? const [];
        return ItemCarrinho(
          idProduto: item['idProduto'] as String,
          idQuiosque: item['idQuiosque'] as String,
          nomeItem: item['nomeItem'] as String,
          valorTotal: (item['valorTotal'] as num).toInt(),
          qtdeItem: (item['qtdeItem'] as num?)?.toInt() ?? 1,
          ingredientes:
              ((item['ingredientes'] as List?) ?? const []).cast<String>(),
          adicionais: adicionais
              .map((a) => AdicionaisItem.fromMap(a as Map<String, dynamic>))
              .toList(),
        );
      }).toList(),
    );
  }
}