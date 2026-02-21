import 'package:app_por_sol/model/item.dart';

class Restaurant {
  final String id;
  final String nome;
  final String descricao;
  final double distancia;
  // final List<String> categorias;
  final List<Item> pratos;
  //final String logo;

  Restaurant({
    required this.id,
    required this.nome,
    required this.descricao,
    required this.distancia,
    required this.pratos,
  });
}
