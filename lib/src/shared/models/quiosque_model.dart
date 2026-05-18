class QuiosqueModel {
  final String idQuiosque;
  final String nomeQuiosque;
  final String? imgPerfilQuiosque;
  final String? imgBannerQuiosque;
  final double avaliacaoQuiosque;
  final String distanciaQuiosque;
  final bool disponivelEntrega;
  final int tempoEspera;
  List<String>? categorias = [];
  final String horarioAbre;
  final String horarioFecha;
  final int qtdeAvaliacoes;

  QuiosqueModel({
    required this.idQuiosque,
    required this.nomeQuiosque,
    this.imgPerfilQuiosque,
    this.imgBannerQuiosque,
    this.avaliacaoQuiosque = 0,
    required this.distanciaQuiosque,
    this.disponivelEntrega = true,
    this.tempoEspera = 0,
    this.categorias,
    this.horarioAbre = "08:00",
    this.horarioFecha = "23:00",
    this.qtdeAvaliacoes = 0,
  });

  // factory QuiosqueModel.fromJson(Map<String, dynamic> json) {
  //   return QuiosqueModel(
  //     nomeQuiosque: json['nome'],
  //     imgPerfilQuiosque: json['imgPerfil'],
  //     imgBannerQuiosque: json['imgBanner'],
  //     avalicaoQuiosque: json['avalicao'],
  //     distanciaQuiosque: json['distancia'],
  //   );
  // }
}