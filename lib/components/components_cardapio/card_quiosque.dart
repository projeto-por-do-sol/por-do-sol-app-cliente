import 'package:app_por_sol/components/components_utils/separadores.dart';
import 'package:app_por_sol/model/restaurant.dart';
import 'package:flutter/material.dart';

class CardQuiosque extends StatelessWidget {
  final Restaurant restaurant;
  final double? altura;
  final double? largura;
  const CardQuiosque({
    required this.restaurant,
    required this.altura,
    required this.largura,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(0.0, -0.5),
      child: SizedBox(
        height: (altura != null) ? altura! * 0.05 : null,
        width: (altura != null) ? largura! * 0.05 : null,
        child: Card(
          margin: EdgeInsets.fromLTRB(10, 180, 10, 40),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(1.0, 20, 1, 1),
                child: Text(
                  restaurant.nome,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
              ),
              Container(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "Preparo Tempo Real",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Separadores.IconeGuardaSol(),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "${restaurant.distancia} KM",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Separadores.IconeGuardaSol(),
                    //Colocar atributo de valor minimo de pedido no obj do quiosque
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "Min R\$20,00",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.grey,
                thickness: 2,
                indent: 15,
                endIndent: 15,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "Preparo",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Separadores.IconeRelogio(),
                  //Colocar atributo de media de tempo de pedido no obj do quiosque
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "30-45 Min",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
