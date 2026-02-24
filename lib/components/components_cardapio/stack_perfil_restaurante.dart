// import 'package:app_por_sol/components/components_cardapio/banner_quiosque.dart';
// import 'package:app_por_sol/components/components_cardapio/card_quiosque.dart';
// import 'package:app_por_sol/components/components_cardapio/logo_quiosque.dart';
// import 'package:app_por_sol/model/restaurant.dart';
// import 'package:flutter/material.dart';

// class StackPerfilRestaurante extends StatelessWidget {
//   final GlobalKey stackTamnho = GlobalKey();
//   final Restaurant restaurant;
//   StackPerfilRestaurante({required this.restaurant});

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       key: stackTamnho,
//       clipBehavior: Clip.none,
//       children: [
//         LogoQuiosque(),
//         //Colocar Banner do restaurante no construtor
//         BannerQuiosque(),

//         CardQuiosque(
//           restaurant: restaurant,
//           altura: (stackTamnho.currentContext != null)
//               ? (stackTamnho.currentContext!.findRenderObject() as RenderBox)
//                     .size
//                     .height
//               : null,
//           largura: (stackTamnho.currentContext != null)
//               ? (stackTamnho.currentContext!.findRenderObject() as RenderBox)
//                     .size
//                     .width
//               : null,
//         ),

//         //Colocar Logo do restaurante no construtor
//         Positioned(top: 120, right: 1, left: 1, child: LogoQuiosque()),
//       ],
//     );
//   }
// }
