import 'package:app_por_sol/model/itens.dart';

class Restaurant {
  final String id;
  final String nome;
  final String descricao;
  final double distancia;
  // final List<String> categorias;
  final List<Itens> pratos;
  //final String logo;

  Restaurant({
    required this.id,
    required this.nome,
    required this.descricao,
    required this.distancia,
    required this.pratos,
  });
}
