import 'package:client_app/src/shared/models/quiosque_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CardQuiosque extends StatefulWidget {
  final QuiosqueModel quiosque;

  const CardQuiosque({
    super.key,
    required this.quiosque,
  });

  @override
  State<CardQuiosque> createState() => _CardQuiosqueState();
}

class _CardQuiosqueState extends State<CardQuiosque> {
  double tamanhoImagem = 70.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
            onTap: () {
              // FocusScope.of(context).unfocus();
              context.push('/quiosquePage', extra: widget.quiosque);
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
                    child: widget.quiosque.imgPerfilQuiosque != null
                        ? Image.asset(
                      "assets/images/${widget.quiosque.imgPerfilQuiosque}",
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
                    width: 150,
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 2,
                      children: [
                        Text(
                          widget.quiosque.nomeQuiosque,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 60,
                              child: Row(
                                children: [
                                  Icon(Icons.star, color: Theme.of(context).colorScheme.outline, size: 20),
                                  const SizedBox(width: 3,),
                                  Text(
                                    widget.quiosque.avalicaoQuiosque.toString(),
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(width: 10),

                            Icon(Icons.directions, color: Theme.of(context).colorScheme.outline, size: 20),
                            const SizedBox(width: 3),
                            Text("${widget.quiosque.distanciaQuiosque}m",
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
