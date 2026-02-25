import 'package:app_por_sol/components/components_utils/app_bar_generic.dart';
import 'package:app_por_sol/model/item.dart';
import 'package:flutter/material.dart';

class Prato extends StatefulWidget {
  final Item pratoSelecionado;
  const Prato({super.key, required this.pratoSelecionado});

  @override
  State<Prato> createState() => PratotState();
}

class PratotState extends State<Prato> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBarGeneric(tex: "hwhhwhwhwhwh"));
  }
}
