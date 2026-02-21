import 'package:app_por_sol/components/components_cardapio/item_item.dart';
import 'package:app_por_sol/model/item.dart';
import 'package:flutter/material.dart';

class ListaPratos extends StatelessWidget {
  final List<Item> list_item;
  const ListaPratos({required this.list_item});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list_item.length,
      itemBuilder: (ctx, index) {
        final item_cardapio = list_item[index];
        return ItemItem(item: item_cardapio);
      },
    );
  }
}
