class ItemQuiosque {
  final String secaoItem;
  final String nomeItem;
  final String descricaoItem;
  final int precoItem;
  final String imgItem;
  final bool disponivel;
  final List<String> ingredientes;
  int qtdeItem;

  ItemQuiosque({
    required this.secaoItem,
    required this.nomeItem,
    required this.descricaoItem,
    required this.precoItem,
    required this.imgItem,
    required this.disponivel,
    this.qtdeItem = 0,
    required this.ingredientes,
  });



}