import 'package:flutter/material.dart';

class AppBarGeneric extends StatelessWidget implements PreferredSizeWidget {
  final String tex;

  AppBarGeneric({required this.tex});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        tex,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.yellowAccent,
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.deepOrange,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
