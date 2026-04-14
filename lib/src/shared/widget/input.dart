import 'package:flutter/material.dart';

class InputCustom extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final bool isPassword;

  const InputCustom({
    super.key,
    required this.label,
    this.controller,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            obscureText: isPassword,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.outline,
                  width: 2.0,
                ),
              ),

              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.outline,
                  width: 3.0,
                ),
              ),

              filled: true,
              fillColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
