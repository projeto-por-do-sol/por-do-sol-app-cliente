class AdicionaisItem {
  final String nomeAdicional;
  final int precoAdicional;

  AdicionaisItem({
    required this.nomeAdicional,
    required this.precoAdicional,
  });

  Map<String, dynamic> toJson() {
    return {
      'nome': nomeAdicional,
      'valor': precoAdicional,
    };
  }

  factory AdicionaisItem.fromMap(Map<String, dynamic> map) {
    return AdicionaisItem(
      nomeAdicional: map['nome'] ?? '',
      precoAdicional: (map['preco'] as int),
    );
  }

}