class ItemCarrinho {
  final String idProduto;
  final String nomeProduto;
  final int valorUnitario;
  final List<String> ingredientes;
  final List<String> adicionais;
  int qtdeItem;

  ItemCarrinho({
    required this.idProduto,
    required this.nomeProduto,
    required this.valorUnitario,
    this.ingredientes = const [],
    this.adicionais = const [],
    this.qtdeItem = 1,
  });


}