import 'package:client_app/src/shared/models/item_quiosque.dart';
import 'package:flutter/material.dart';

class ItemPage extends StatefulWidget {
  ItemQuiosque item;

  ItemPage({
    super.key,
    required this.item,
  });

  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item.nomeItem),
        centerTitle: true,
      ),
    );
  }
}
