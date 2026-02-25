import 'package:app_por_sol/model/enuns/tipo_item.dart';

class Item {
  final String id;
  final String tituloPrato;
  final String descricaoPrato;
  final String ingredientes;
  final double precos;
  final TipoItem tipo;

  Item({
    required this.id,
    required this.tituloPrato,
    required this.descricaoPrato,
    required this.ingredientes,
    required this.precos,
    required this.tipo,
  });
}
