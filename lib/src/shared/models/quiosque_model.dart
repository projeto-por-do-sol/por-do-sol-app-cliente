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

  factory QuiosqueModel.fromJson(Map<String, dynamic> json) {
    return QuiosqueModel(
      idQuiosque: json['idQuiosque']?.toString() ?? '',
      nomeQuiosque: json['nomeQuiosque'] ?? '',
      imgPerfilQuiosque: json['imgPerfilQuiosque'],
      imgBannerQuiosque: json['imgBannerQuiosque'],
      avaliacaoQuiosque: (json['avaliacaoQuiosque'] as num?)?.toDouble() ?? 0,
      distanciaQuiosque: json['distanciaQuiosque']?.toString() ?? '0',
      disponivelEntrega: json['disponivelEntrega'] ?? true,
      tempoEspera: (json['tempoEspera'] as num?)?.toInt() ?? 0,
      categorias:
          (json['categorias'] as List?)?.map((e) => e.toString()).toList(),
      horarioAbre: json['horarioAbre'] ?? '08:00',
      horarioFecha: json['horarioFecha'] ?? '23:00',
      qtdeAvaliacoes: (json['qtdeAvaliacoes'] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idQuiosque': idQuiosque,
      'nomeQuiosque': nomeQuiosque,
      'imgPerfilQuiosque': imgPerfilQuiosque,
      'imgBannerQuiosque': imgBannerQuiosque,
      'avaliacaoQuiosque': avaliacaoQuiosque,
      'distanciaQuiosque': distanciaQuiosque,
      'disponivelEntrega': disponivelEntrega,
      'tempoEspera': tempoEspera,
      'categorias': categorias,
      'horarioAbre': horarioAbre,
      'horarioFecha': horarioFecha,
      'qtdeAvaliacoes': qtdeAvaliacoes,
    };
  }
}