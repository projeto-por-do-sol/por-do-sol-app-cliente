import 'package:app_por_sol/screens/quiosques.dart';
import 'package:flutter/material.dart';

class AppBottomNavigator extends StatefulWidget {
  const AppBottomNavigator({super.key});

  @override
  State<AppBottomNavigator> createState() => _AppBottomNavigatorState();
}

class _AppBottomNavigatorState extends State<AppBottomNavigator> {
  int _selectScreen = 0;
  final List<Widget> _screens = [Quiosques()];

  void _onClickItem(int index) {
    setState(() {
      _selectScreen = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _selectScreen,
      onTap: _onClickItem,
      fixedColor: Colors.redAccent,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.restaurant_menu),
          label: 'QUIOSQUES',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.ac_unit), label: 'BABABA'),
        BottomNavigationBarItem(icon: Icon(Icons.ac_unit), label: 'kakakakak'),
      ],
    );
  }
}
