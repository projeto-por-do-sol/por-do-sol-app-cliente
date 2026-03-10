import 'package:app_por_sol/components/components_cardapio/banner_quiosque.dart';
import 'package:app_por_sol/components/components_cardapio/card_quiosque.dart';
import 'package:app_por_sol/components/components_cardapio/item_item.dart';
// import 'package:app_por_sol/components/components_cardapio/lista_pratos.dart';
import 'package:app_por_sol/components/components_cardapio/logo_quiosque.dart';
import 'package:app_por_sol/components/components_utils/separadores.dart';
import 'package:app_por_sol/model/enuns/tipo_item.dart';
import 'package:app_por_sol/model/item.dart';
import 'package:app_por_sol/model/restaurant.dart';
import 'package:flutter/material.dart';
import 'package:app_por_sol/components/components_utils/app_bar_generic.dart';

class Cardapio extends StatelessWidget {
  Restaurant restaurant;
  final GlobalKey stackTamnho = GlobalKey();
  Cardapio({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    final solidos = restaurant.pratos
        .where((item) => item.tipo == TipoItem.SOLIDO)
        .toList();
    final bebidas = restaurant.pratos
        .where((item) => item.tipo == TipoItem.BEBIDA)
        .toList();
    return SafeArea(
      child: Scaffold(
        // appBar: AppBarGeneric(tex: "Cardápio"),
        body: CustomScrollView(
          slivers: [
            /// HEADER DINÂMICO
            SliverAppBar(
              expandedHeight: 193,
              pinned: false,
              floating: false,
              backgroundColor: Colors.transparent,
              elevation: 0,

              flexibleSpace: LayoutBuilder(
                builder: (context, constraints) {
                  final double alturaAtual = constraints.maxHeight;
                  final double percentual =
                      (alturaAtual - kToolbarHeight) / (250 - kToolbarHeight);

                  final double logoSize = 100 * percentual.clamp(0.7, 1);

                  return Stack(
                    fit: StackFit.expand,
                    clipBehavior: Clip.none,
                    children: [
                      /// BANNER (vai sumindo)
                      Opacity(
                        opacity: percentual.clamp(1.0, 1.0),
                        child: BannerQuiosque(),
                      ),

                      Positioned(
                        bottom: 0,
                        left: 1,
                        right: 1,
                        child: Transform.translate(
                          offset: Offset(0, 70),
                          child: CardQuiosque(restaurant: restaurant),
                        ),
                      ),

                      /// LOGO (diminui)
                      Positioned(
                        top: 100 * percentual,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: SizedBox(
                            width: logoSize,
                            height: logoSize,
                            child: LogoQuiosque(),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),

            /// LISTA DE PRATOS
            SliverList(
              delegate: SliverChildListDelegate([
                const SizedBox(height: 70),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text(
                    "Sólidos",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                ),
                const Divider(color: Colors.black),
                ...solidos.map((item) => ItemItem(item: item)),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Bebidas",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                ),
                ...bebidas.map((item) => ItemItem(item: item)),
                SizedBox(height: 50),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
