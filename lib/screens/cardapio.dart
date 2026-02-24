import 'package:app_por_sol/components/components_cardapio/banner_quiosque.dart';
import 'package:app_por_sol/components/components_cardapio/card_quiosque.dart';
import 'package:app_por_sol/components/components_cardapio/item_item.dart';
// import 'package:app_por_sol/components/components_cardapio/lista_pratos.dart';
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
      // appBar: AppBarGeneric(tex: "Cardápio"),
      body: CustomScrollView(
        slivers: [
          /// HEADER DINÂMICO
          SliverAppBar(
            expandedHeight: 180,
            pinned: false,
            floating: false,
            backgroundColor: Colors.transparent,
            elevation: 0,

            flexibleSpace: LayoutBuilder(
              builder: (context, constraints) {
                final double alturaAtual = constraints.maxHeight;
                final double percentual =
                    (alturaAtual - kToolbarHeight) / (600 - kToolbarHeight);

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
            delegate: SliverChildListDelegate(
              restaurant.pratos.map((item) => ItemItem(item: item)).toList(),
            ),
          ),
        ],
      ),
    );
    // return Scaffold(
    //   appBar: AppBarGeneric(tex: "Cardapio"),
    //   //Componentizar
    //   body: Column(
    //     children: [
    //       Stack(
    //         key: stackTamnho,
    //         clipBehavior: Clip.none,
    //         children: [
    //           LogoQuiosque(),
    //           //Colocar Banner do restaurante no construtor
    //           BannerQuiosque(),

    //           CardQuiosque(
    //             restaurant: restaurant,
    //             altura: (stackTamnho.currentContext != null)
    //                 ? (stackTamnho.currentContext!.findRenderObject()
    //                           as RenderBox)
    //                       .size
    //                       .height
    //                 : null,
    //             largura: (stackTamnho.currentContext != null)
    //                 ? (stackTamnho.currentContext!.findRenderObject()
    //                           as RenderBox)
    //                       .size
    //                       .width
    //                 : null,
    //           ),

    //           //Colocar Logo do restaurante no construtor
    //           Positioned(top: 120, right: 1, left: 1, child: LogoQuiosque()),
    //         ],
    //       ),
    //       Expanded(child: ListaPratos(list_item: list_item)),
    //     ],
    //   ),
    // );
  }
}
