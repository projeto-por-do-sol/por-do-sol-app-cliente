import 'package:flutter/material.dart';

class CardQuiosque extends StatefulWidget {
  final String nomeQuiosque = "Nome de Teste";
  final String? imagemQuiosque = "logo.png";
  final String avalicaoQuiosque = "4,5";
  final String distanciaQuiosque = "100";

  const CardQuiosque({
    super.key,
    // required this.nomeQuiosque,
    // this.imagemQuiosque,
    // required this.avalicaoQuiosque,
    // required this.distanciaQuiosque,
  });

  @override
  State<CardQuiosque> createState() => _CardQuiosqueState();
}

class _CardQuiosqueState extends State<CardQuiosque> {
  double tamanhoImagem = 70.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/quiosquePage',
            arguments: {
              'nome': widget.nomeQuiosque,
              'imagem': widget.imagemQuiosque,
              'avaliacao': widget.avalicaoQuiosque,
              'distancia': widget.distanciaQuiosque,
              },
            );
          },

        child: Container(

          margin: EdgeInsets.symmetric(horizontal: 20),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.1),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).colorScheme.surface,
          ),
          height: 100,
          width: double.infinity,
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: widget.imagemQuiosque != null
                    ? Image.asset(
                  "assets/images/${widget.imagemQuiosque}",
                  height: tamanhoImagem,
                  width: tamanhoImagem,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: tamanhoImagem,
                      width: tamanhoImagem,
                      color: Colors.grey[300],
                      child: const Icon(Icons.image_not_supported, color: Colors.grey),
                    );
                  },
                )
                    : Container(
                  height: tamanhoImagem,
                  width: tamanhoImagem,
                  color: Colors.grey[300],
                  child: const Icon(Icons.image, color: Colors.grey),
                ),
              ),

              const SizedBox(width: 10),

              Container(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 2,
                  children: [
                    Text(
                      widget.nomeQuiosque,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    Row(
                      children: [
                        Row(
                            children: [
                              Icon(Icons.star, color: Theme.of(context).colorScheme.outline, size: 20),
                              const SizedBox(width: 3,),
                              Text(
                                widget.avalicaoQuiosque,
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                              ),

                              const SizedBox(width: 10),

                              Icon(Icons.directions, color: Theme.of(context).colorScheme.outline, size: 20),
                              const SizedBox(width: 3),
                              Text("${widget.distanciaQuiosque}m",
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          )
        ),
    );
  }
}
