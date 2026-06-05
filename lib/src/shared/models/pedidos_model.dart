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
}