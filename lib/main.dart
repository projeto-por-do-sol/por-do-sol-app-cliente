import 'package:app_por_sol/Datas/datas_mock_restaurants.dart';
import 'package:app_por_sol/components/components_utils/app_bar_generic.dart';
import 'package:app_por_sol/components/components_quiosques/lista_restaurant.dart';
import 'package:app_por_sol/routes/app_routes.dart';
import 'package:app_por_sol/screens/quiosques.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Quiosques(),
      routes: {AppRoutes.ListQuisques: (ctx) => Quiosques()},
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarGeneric(tex: 'Principal'),
      body: ListaRestaurant(restaurant_list: datasRestaurants),
    );
  }
}
