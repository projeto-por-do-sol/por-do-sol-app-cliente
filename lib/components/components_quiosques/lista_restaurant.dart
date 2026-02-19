import 'package:app_por_sol/components/components_quiosques/item_restaurante.dart';
import 'package:app_por_sol/model/restaurant.dart';
import 'package:flutter/material.dart';

class ListaRestaurant extends StatelessWidget {
  final List<Restaurant> restaurant_list;

  ListaRestaurant({required this.restaurant_list});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: restaurant_list.length,
      itemBuilder: (ctx, index) {
        final rest = restaurant_list[index];
        return ItemRestaurante(rest: rest);
      },
    );
  }
}
