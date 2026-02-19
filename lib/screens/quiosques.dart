import 'package:app_por_sol/components/components_utils/app_bottom_navigator.dart';
import 'package:flutter/material.dart';
import 'package:app_por_sol/Datas/datas_mock_restaurants.dart';
import 'package:app_por_sol/components/components_utils/app_bar_generic.dart';
import 'package:app_por_sol/components/components_quiosques/lista_restaurant.dart';

//Cahama Componentes para criar a lista de quiosques
class Quiosques extends StatelessWidget {
  const Quiosques({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarGeneric(tex: 'Lista de Quiosques'),
      body: ListaRestaurant(restaurant_list: datasRestaurants),
      bottomNavigationBar: AppBottomNavigator(),
    );
  }
}
