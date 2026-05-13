import 'package:client_app/src/shared/models/adicionaisItem.dart';
import 'package:client_app/src/shared/models/item_quiosque.dart';
import 'package:client_app/src/shared/models/quiosque_model.dart';
import 'package:client_app/src/shared/widget/CardItens.dart';
import 'package:client_app/src/shared/widget/appBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  AdicionaisItem adicional1 = AdicionaisItem(
      nomeAdicional: "ketchup",
      precoAdicional: 200
  );

  AdicionaisItem adicional2 = AdicionaisItem(
      nomeAdicional: "mostarda",
      precoAdicional: 300
  );

  AdicionaisItem adicional3 = AdicionaisItem(
      nomeAdicional: "cheddar",
      precoAdicional: 1500
  );

  AdicionaisItem adicional4 = AdicionaisItem(
      nomeAdicional: "bacon",
      precoAdicional: 1800
  );

  late List<AdicionaisItem> listaAdicionais = [adicional1, adicional2, adicional3, adicional4];

  late ItemQuiosque item1 = ItemQuiosque(
      secaoItem: "Porções",
      nomeItem: "Batata frita",
      descricaoItem: "Batata inglesa frita com sal Batata inglesa frita com sal Batata inglesa frita com sal Batata inglesa frita com sal Batata inglesa frita com sal",
      precoItem: 4590,
      imgItem: "https://www.tendaatacado.com.br/dicas/wp-content/webp-express/webp-images/uploads/2022/06/como-fazer-batata-frita-topo.jpg.webp",
      disponivel: true,
      ingredientes: ["batata", "sal"],
      adicionais: listaAdicionais,
  );
  late List<ItemQuiosque> listaItens = [item1];

  var corVerde = 0xff4A8C7A;

  // dynamic imagemBanner(){
  //   double tamanhoImagem = 300;
  //   return ClipRRect(
  //     //Tamanho Imagem: 150x90
  //     // borderRadius: BorderRadius.circular(20),
  //     // borderRadius: BorderRadius.only(topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),
  //     child: widget.quiosque.imgBannerQuiosque != null
  //         ? Image.network(
  //       widget.quiosque.imgBannerQuiosque.toString(),
  //       height: tamanhoImagem,
  //       width: double.infinity,
  //       fit: BoxFit.cover,
  //       // fit: BoxFit.fitWidth,
  //       errorBuilder: (context, error, stackTrace) {
  //         return Container(
  //           height: tamanhoImagem,
  //           width: double.infinity,
  //           color: Colors.grey[300],
  //           child: const Icon(Icons.image_not_supported, color: Colors.grey, size: 40,),
  //         );
  //       },
  //     )
  //         : Container(
  //       height: tamanhoImagem,
  //       width: double.infinity,
  //       color: Colors.grey[300],
  //       child: const Icon(Icons.image, color: Colors.grey, size: 40,),
  //     ),
  //   );
  // }

  dynamic funcionamentoQuiosque(){
    bool quiosqueAberto = true;
    return Container(
      height: 30,
      alignment: Alignment.center,
      margin: EdgeInsets.only(right: 10),
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: quiosqueAberto? Color(corVerde) : Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(20),
      ),
      child:
        quiosqueAberto ? Text("Aberto",
          style: TextStyle(color: Theme.of(context).colorScheme.onTertiary, fontWeight: FontWeight.w600),
        ) : Text("Fechado",
          style: TextStyle(color: Theme.of(context).colorScheme.onTertiary, fontWeight: FontWeight.w600),
        ),
    );
  }

  dynamic notaQuiosque(){
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSurface,
        borderRadius: BorderRadius.circular(20),
      ),

      height: 30,
      child: Row(
          children: [
            Icon(Icons.star_rate_rounded,
              color: Theme.of(context).colorScheme.outline,
              size: 14,
            ),

            const SizedBox(width: 3),

            Text(
              "${widget.quiosque.avaliacaoQuiosque.toStringAsFixed(1)} (${widget.quiosque.qtdeAvaliacoes.toString()})",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),

          ]
      ),
    );
  }

  dynamic containerInfoQuiosque(IconData icone, String texto, String subtexto){
    return Container(
      width: 120,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onTertiary,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Theme.of(context).colorScheme.secondary,
          width: 1,
        )
      ),
      child: Column(
        children: [
          Icon(icone, size: 20, color: Theme.of(context).colorScheme.outline),
          SizedBox(height: 5,),
          Text(texto, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
          Text(subtexto, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  // Widget botaoAdicionar(){
  //
  //   return Container(
  //     padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
  //     decoration: BoxDecoration(
  //       color: Theme.of(context).colorScheme.primary,
  //       borderRadius: BorderRadius.circular(20),
  //     ),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //         // SizedBox(
  //         //   width: 55,
  //         //   child: Row(
  //         //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         //     children: [
  //         //       Text(qtdeItem.toString(),
  //         //         style: TextStyle(
  //         //           fontSize: 14,
  //         //           fontWeight: FontWeight.w600,
  //         //           color: Theme.of(context).colorScheme.onSecondary,
  //         //         ),
  //         //       ),
  //         //
  //         //       Text(qtdeItem < 2 ? "item" : "itens",
  //         //         style: TextStyle(
  //         //           fontSize: 14,
  //         //           fontWeight: FontWeight.w600,
  //         //           color: Theme.of(context).colorScheme.onSecondary,
  //         //         ),
  //         //       ),
  //         //     ],
  //         //   ),
  //         // ),
  //
  //         Text("Adicionar ao carrinho",
  //           style: TextStyle(
  //               fontSize: 16,
  //               fontWeight: FontWeight.w600,
  //               color: Theme.of(context).colorScheme.onSecondary,
  //           ),
  //         ),
  //
  //         SizedBox(
  //           width: 80,
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.start,
  //             children: [
  //               Text("R\$ ",
  //                 style: TextStyle(
  //                   fontSize: 14,
  //                   fontWeight: FontWeight.w600,
  //                   color: Theme.of(context).colorScheme.onSecondary,
  //                 ),
  //               ),
  //
  //               Text(precoCarrinho.toStringAsFixed(2).replaceAll('.', ','),
  //                 style: TextStyle(
  //                   fontSize: 14,
  //                   fontWeight: FontWeight.w600,
  //                   color: Theme.of(context).colorScheme.onSecondary,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    double tamanhoImagem = 300;
    final quiosque = widget.quiosque;

    return Scaffold(
      extendBodyBehindAppBar: true,

      appBar: CustomAppBar(),

      body: SingleChildScrollView(
          child: Column(
              children: [

                SizedBox(
                  height: tamanhoImagem,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      Container(
                        color: Colors.grey[300],
                        child: const Center(
                          child: Icon(Icons.image, color: Colors.grey, size: 40),
                        ),
                      ),

                      if (quiosque.imgBannerQuiosque != null)
                        Image.network(
                          widget.quiosque.imgBannerQuiosque.toString(),
                          height: tamanhoImagem,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              height: tamanhoImagem,
                              width: double.infinity,
                              color: Colors.grey[300],
                              child: const Icon(Icons.image_not_supported, color: Colors.grey, size: 40,),
                            );
                          },
                        ),

                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        alignment: Alignment.bottomLeft,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                funcionamentoQuiosque(),
                                notaQuiosque(),
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                              decoration: BoxDecoration(
                                color: Color(0xffABA387),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(widget.quiosque.nomeQuiosque.toString(),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).colorScheme.onTertiary,
                                ),
                              ),
                            ),
                          ]
                        )
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20,),

                SafeArea(
                  top: false,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            containerInfoQuiosque(Icons.hourglass_bottom_rounded, "~${widget.quiosque.tempoEspera} min", "Espera"),
                            containerInfoQuiosque(Icons.location_on_rounded, "${widget.quiosque.distanciaQuiosque}m", "Distância"),
                            containerInfoQuiosque(Icons.access_time_filled_rounded, "${widget.quiosque.horarioFecha}", "Fecha"), //TODO: Fazer para o horário de abrir
                          ]
                        ),

                        SizedBox(height: 20,),

                        ...listaItens
                            .where((item) => item.disponivel)
                            .map((item) => CardItens(item: item)),

                      ],
                    ),
                ),
              ],
            ),
        ),

    );
  }
}