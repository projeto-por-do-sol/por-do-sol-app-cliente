class QuiosqueModel {
  final String nomeQuiosque;
  final String? imgPerfilQuiosque;
  final String? imgBannerQuiosque;
  final String? avalicaoQuiosque;
  final String? distanciaQuiosque;
  final bool disponivelEntrega;
  final int? tempoEspera;
  List<String>? categorias = [];
  final String? horarioAtendimento;

  QuiosqueModel({
    required this.nomeQuiosque,
    this.imgPerfilQuiosque,
    this.imgBannerQuiosque,
    this.avalicaoQuiosque,
    this.distanciaQuiosque,
    this.disponivelEntrega = true,
    this.tempoEspera,
    this.categorias,
    this.horarioAtendimento,
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