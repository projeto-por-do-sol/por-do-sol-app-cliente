import 'package:flutter/material.dart';

class Contador extends StatefulWidget {
  const Contador({super.key});

  @override
  State<Contador> createState() => ContadortState();
}

class ContadortState extends State<Contador> {
  int cont = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: () => setState(() {
            cont++;
          }),
          icon: Icon(Icons.add),
        ),

        SizedBox(width: 10),

        Text("$cont"),

        SizedBox(width: 10),

        IconButton(
          onPressed: () {
            if (cont > 0) {
              setState(() {
                cont--;
              });
            }
          },
          icon: Icon(Icons.remove),
        ),
      ],
    );
  }
}
