import 'package:client_app/src/shared/models/quiosque_model.dart';
import 'package:flutter/material.dart';

class QuiosquePage extends StatefulWidget {
  final QuiosqueModel quiosque;

  QuiosquePage({
    super.key,
    required this.quiosque,
  });

  @override
  State<QuiosquePage> createState() => _QuiosquePageState();
}

class _QuiosquePageState extends State<QuiosquePage> {

  @override
  Widget build(BuildContext context) {
    final quiosque = widget.quiosque;

    final String nomeQuiosque = quiosque.nomeQuiosque;
    final String? imgBannerQuiosque = quiosque.imgBannerQuiosque;
    final String? imgPerfilQuiosque = quiosque.imgPerfilQuiosque;
    final String? avalicaoQuiosque = quiosque.avalicaoQuiosque;
    final String? distanciaQuiosque = quiosque.distanciaQuiosque;

    return Scaffold(
      appBar: AppBar(
        title: Text(nomeQuiosque),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          child: Column(
            children: [
              Image.asset("assets/images/${imgBannerQuiosque}"),
              Image.asset("assets/images/${imgPerfilQuiosque}"),
              Text(nomeQuiosque),
              Text(avalicaoQuiosque.toString()),
              Text(distanciaQuiosque.toString()),
            ],
          ),
        ),
      ),
    );
  }
}
