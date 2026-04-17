import 'package:flutter/material.dart';

class QuiosquePage extends StatefulWidget {
  // Para receber os dados do CardQuiosque (formato de objeto)
  // final quiosque = ModalRoute.of(context)!.settings.arguments as CardQuiosque;
  QuiosquePage({
    super.key,
  });

  @override
  State<QuiosquePage> createState() => _QuiosquePageState();
}

class _QuiosquePageState extends State<QuiosquePage> {

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final String nomeQuiosque = args['nome'] ?? "Nome não encontrado";
    final String? imagemQuiosque = args['imagem'];
    final String? avalicaoQuiosque = args['avaliacao'];
    final String? distanciaQuiosque = args['distancia'];

    return Scaffold(
      appBar: AppBar(
        title: Text(nomeQuiosque),
        centerTitle: true,
      ),
      body: Container(
        child: Text(nomeQuiosque),
      ),
    );
  }
}
