class QuiosqueModel {
  final String nomeQuiosque;
  final String? imgPerfilQuiosque;
  final String? imgBannerQuiosque;
  final double avaliacaoQuiosque;
  final String distanciaQuiosque;
  final bool disponivelEntrega;
  final int tempoEspera;
  List<String>? categorias = [];
  final String? horarioAbre;
  final String? horarioFecha;
  final int qtdeAvaliacoes;

  QuiosqueModel({
    required this.nomeQuiosque,
    this.imgPerfilQuiosque,
    this.imgBannerQuiosque,
    this.avaliacaoQuiosque = 0,
    required this.distanciaQuiosque,
    this.disponivelEntrega = true,
    this.tempoEspera = 0,
    this.categorias,
    this.horarioAbre,
    this.horarioFecha,
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