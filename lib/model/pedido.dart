import 'package:app_por_sol/model/item.dart';

class Pedido {
  final String id;
  final List<Item> pedidos;
  final DateTime horaPedida;
  final String tipoPagamento;

  Pedido(this.id, this.pedidos, this.horaPedida, this.tipoPagamento);
}
