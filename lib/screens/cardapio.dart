import 'package:app_por_sol/components/components_cardapio/banner_quiosque.dart';
import 'package:app_por_sol/components/components_cardapio/card_quiosque.dart';
import 'package:app_por_sol/components/components_cardapio/lista_pratos.dart';
import 'package:app_por_sol/components/components_cardapio/logo_quiosque.dart';
import 'package:app_por_sol/components/components_utils/separadores.dart';
import 'package:app_por_sol/model/item.dart';
import 'package:app_por_sol/model/restaurant.dart';
import 'package:flutter/material.dart';
import 'package:app_por_sol/components/components_utils/app_bar_generic.dart';

class Cardapio extends StatelessWidget {
  Restaurant restaurant;
  final GlobalKey stackTamnho = GlobalKey();
  Cardapio({required Restaurant this.restaurant});

  @override
  Widget build(BuildContext context) {
    final List<Item> list_item = restaurant.pratos;
    return Scaffold(
      appBar: AppBarGeneric(tex: "Cardapio"),
      //Componentizar
      body: Column(
        children: [
          Stack(
            key: stackTamnho,
            clipBehavior: Clip.none,
            children: [
              LogoQuiosque(),
              //Colocar Banner do restaurante no construtor
              BannerQuiosque(),

              CardQuiosque(
                restaurant: restaurant,
                altura: (stackTamnho.currentContext != null)
                    ? (stackTamnho.currentContext!.findRenderObject()
                              as RenderBox)
                          .size
                          .height
                    : null,
                largura: (stackTamnho.currentContext != null)
                    ? (stackTamnho.currentContext!.findRenderObject()
                              as RenderBox)
                          .size
                          .width
                    : null,
              ),

              //Colocar Logo do restaurante no construtor
              Positioned(top: 120, right: 1, left: 1, child: LogoQuiosque()),
            ],
          ),
          Expanded(child: ListaPratos(list_item: list_item)),
        ],
      ),
    );
  }
}
