import 'package:app_por_sol/model/restaurant.dart';
import 'package:flutter/material.dart';
import 'package:app_por_sol/components/components_utils/app_bar_generic.dart';

class Cardapio extends StatelessWidget {
  Restaurant restaurant;
  Cardapio({required Restaurant this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarGeneric(tex: "Cardapio"),
      body: Container(
        child: Stack(
          children: [
            Image.network(
              'https://www.estadao.com.br/resizer/v2/5776BB3SUJBFFNFYYDEB673PQQ.jpeg?quality=80&auth=e3574cbc8e7fd6f81aa563d250bf079da0935d5fd4d543a72743c3f54461ceee&width=1075&height=527&smart=true',
            ),

            Align(
              alignment: Alignment(0.0, -0.5),
              child: Container(
                width: 10,
                constraints: BoxConstraints(minHeight: 100),
                child: Card(
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          restaurant.nome,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment(0.0, -0.65),
              child: Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(
                      'https://www.estadao.com.br/resizer/v2/5776BB3SUJBFFNFYYDEB673PQQ.jpeg?quality=80&auth=e3574cbc8e7fd6f81aa563d250bf079da0935d5fd4d543a72743c3f54461ceee&width=1075&height=527&smart=true',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
