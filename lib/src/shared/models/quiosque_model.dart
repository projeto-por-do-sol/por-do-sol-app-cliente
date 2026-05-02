class QuiosqueModel {
  final String nomeQuiosque;
  final String? imgPerfilQuiosque;
  final String? imgBannerQuiosque;
  final String? avalicaoQuiosque;
  final String? distanciaQuiosque;
  final bool disponivelEntrega;

  QuiosqueModel({
    required this.nomeQuiosque,
    this.imgPerfilQuiosque,
    this.imgBannerQuiosque,
    this.avalicaoQuiosque,
    this.distanciaQuiosque,
    this.disponivelEntrega = true,
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