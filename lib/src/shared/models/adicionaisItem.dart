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
      'preco': precoAdicional,
    };
  }

  factory AdicionaisItem.fromMap(Map<String, dynamic> map) {
    return AdicionaisItem(
      nomeAdicional: map['nome'] ?? '',
      precoAdicional: (map['preco'] as int?) ?? 0,
    );
  }

}