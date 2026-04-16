import 'package:flutter/material.dart';

class CustomTitle extends StatelessWidget {
  final String label;

  const CustomTitle({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Text(label.toUpperCase(),
        style: Theme.of(context).textTheme.headlineLarge);
  }
}
