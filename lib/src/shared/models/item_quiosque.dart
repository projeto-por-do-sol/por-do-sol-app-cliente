import 'package:client_app/src/shared/models/adicionaisItem.dart';

class ItemQuiosque {
  final String idItem;
  final String idQuiosque;
  final String secaoItem;
  final String nomeItem;
  final String descricaoItem;
  final int precoItem;
  final String imgItem;
  final bool disponivel;
  final List<String> ingredientes;
  final List<AdicionaisItem> adicionais;
  int qtdeItem;

  ItemQuiosque({
    required this.idItem,
    required this.idQuiosque,
    required this.secaoItem,
    required this.nomeItem,
    required this.descricaoItem,
    required this.precoItem,
    required this.imgItem,
    required this.disponivel,
    this.qtdeItem = 0,
    required this.ingredientes,
    required this.adicionais,
  });

  factory ItemQuiosque.fromJson(Map<String, dynamic> json) {
    return ItemQuiosque(
      idItem: json['idItem']?.toString() ?? '',
      idQuiosque: json['idQuiosque']?.toString() ?? '',
      secaoItem: json['secaoItem'] ?? '',
      nomeItem: json['nomeItem'] ?? '',
      descricaoItem: json['descricaoItem'] ?? '',
      precoItem: (json['precoItem'] as num?)?.toInt() ?? 0,
      imgItem: json['imgItem'] ?? '',
      disponivel: json['disponivel'] ?? true,
      qtdeItem: (json['qtdeItem'] as num?)?.toInt() ?? 0,
      ingredientes:
          (json['ingredientes'] as List?)?.map((e) => e.toString()).toList() ??
              [],
      adicionais: (json['adicionais'] as List?)
              ?.map((e) => AdicionaisItem.fromMap(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idItem': idItem,
      'idQuiosque': idQuiosque,
      'secaoItem': secaoItem,
      'nomeItem': nomeItem,
      'descricaoItem': descricaoItem,
      'precoItem': precoItem,
      'imgItem': imgItem,
      'disponivel': disponivel,
      'qtdeItem': qtdeItem,
      'ingredientes': ingredientes,
      'adicionais': adicionais.map((e) => e.toJson()).toList(),
    };
  }
}