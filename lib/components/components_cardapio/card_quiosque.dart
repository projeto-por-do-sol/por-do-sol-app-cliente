import 'dart:math';

import 'package:app_por_sol/components/components_utils/separadores.dart';
import 'package:app_por_sol/model/restaurant.dart';
import 'package:flutter/material.dart';

class CardQuiosque extends StatelessWidget {
  final Restaurant restaurant;

  const CardQuiosque({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// NOME
            Center(
              child: Text(
                restaurant.nome,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
            ),

            const SizedBox(height: 8),

            /// INFORMAÇÕES
            Wrap(
              spacing: 3,
              children: [
                const Text(
                  "Preparo Tempo Real",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),

                Separadores.IconeGuardaSol(),

                Text(
                  "${restaurant.distancia} KM",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),

                Separadores.IconeGuardaSol(),

                const Text(
                  "R\$200,00 Min",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
              ],
            ),

            const Divider(),

            /// TEMPO
            Row(
              children: [
                const Text(
                  "Preparo",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 8),
                Separadores.IconeRelogio(),
                const SizedBox(width: 8),
                const Text(
                  "30-45 Min",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
