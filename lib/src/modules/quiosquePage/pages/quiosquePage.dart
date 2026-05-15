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

class ItemCarrinho {
  final String nomeItem;
  int qtdItem;

  ItemCarrinho({
    required this.nomeItem,
    required this.qtdItem,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is ItemCarrinho &&
              runtimeType == other.runtimeType &&
              nomeItem == other.nomeItem;

  @override
  int get hashCode => nomeItem.hashCode;
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

  late ItemQuiosque item2 = ItemQuiosque(
    secaoItem: "Porções",
    nomeItem: "Iscas de Frango",
    descricaoItem: "Peito de frango empanado e frito, crocante por fora e suculento por dentro. Acompanha molho da casa.",
    precoItem: 3800,
    imgItem: "https://www.sabornamesa.com.br/media/k2/items/cache/dcca011eac737955750c5f2f4e56b627_XL.jpg",
    disponivel: true,
    ingredientes: ["frango", "farinha de rosca", "tempero especial"],
    adicionais: listaAdicionais,
  );

  late ItemQuiosque item3 = ItemQuiosque(
    secaoItem: "Bebidas",
    nomeItem: "Suco de Laranja",
    descricaoItem: "Suco natural da fruta, espremido na hora. Fonte de vitamina C, refrescante e sem conservantes.",
    precoItem: 1200,
    imgItem: "https://www.sabornamesa.com.br/media/k2/items/cache/b018fd5ec8f1b90a1c8015900c2c2630_XL.jpg",
    disponivel: true,
    ingredientes: ["laranja"],
    adicionais: [],
  );

  late ItemQuiosque item4 = ItemQuiosque(
    secaoItem: "Hambúrgueres",
    nomeItem: "X-Salada Especial",
    descricaoItem: "Pão brioche, blend bovino 150g, queijo prato, alface, tomate, cebola roxa e maionese artesanal.",
    precoItem: 3290,
    imgItem: "https://s2-receitas.glbimg.com/Td050XeFMOBB7XFeJigA5voIlvE=/0x0:1200x675/984x0/smart/filters:strip_icc()/i.s3.glbimg.com/v1/AUTH_1f540e0b94d8437dbbc39d567a1dee68/internal_photos/bs/2024/7/K/ehv3mfQjmY0VivlyFd8g/x-salada-classico.jpg",
    disponivel: true,
    ingredientes: ["carne bovina", "queijo", "alface", "tomate", "pão"],
    adicionais: listaAdicionais,
  );

  late ItemQuiosque item5 = ItemQuiosque(
    secaoItem: "Porções",
    nomeItem: "Anéis de Cebola",
    descricaoItem: "Cebolas selecionadas empanadas com farinha panko, fritas até ficarem douradas e muito crocantes.",
    precoItem: 2550,
    imgItem: "https://guiadacozinha.com.br/wp-content/uploads/2018/05/aneldecebola.webp",
    disponivel: true,
    ingredientes: ["cebola", "farinha panko"],
    adicionais: listaAdicionais,
  );

  late ItemQuiosque item6 = ItemQuiosque(
    secaoItem: "Sobremesas",
    nomeItem: "Petit Gâteau",
    descricaoItem: "Bolinho quente de chocolate com recheio cremoso. Acompanha uma bola de sorvete de baunilha.",
    precoItem: 2200,
    imgItem: "https://s2-receitas.glbimg.com/PSo7shjUPc3x5w_8zMTj3J4ZrEM=/0x0:1280x800/984x0/smart/filters:strip_icc()/i.s3.glbimg.com/v1/AUTH_1f540e0b94d8437dbbc39d567a1dee68/internal_photos/bs/2022/E/p/KwxNhgRFSwV6vTBCzmqA/petit-gateau.jpg",
    disponivel: true,
    ingredientes: ["chocolate", "sorvete de baunilha"],
    adicionais: [],
  );

  late List<ItemQuiosque> listaItens = [item1, item2, item3, item4, item5, item6];

  var corVerde = 0xff4A8C7A;
  int precoCarrinho = 0;
  List<ItemCarrinho> ItensAdicionarCarrinho = [];

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

  Widget botaoAdicionar() {
    calcularQtdItens() {
      int qtdItens = 0;
      for (var item in ItensAdicionarCarrinho) {
        qtdItens += item.qtdItem;
      }
      return qtdItens;
    }

    calcularPrecoCarrinho() {
      double precoCarrinho = 0;
      for (var item in ItensAdicionarCarrinho) {
        precoCarrinho += item.qtdItem *
            listaItens
                .firstWhere((element) => element.nomeItem == item.nomeItem)
                .precoItem;
      }
      return precoCarrinho / 100;
    }

    return ElevatedButton(
      onPressed: () {

      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary,
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 55,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  calcularQtdItens().toString(),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
                ),
                Text(
                  calcularQtdItens() < 2 ? "item" : "itens",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
                ),
              ],
            ),
          ),
          Text(
            "Adicionar ao carrinho",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.onSecondary,
            ),
          ),
          SizedBox(
            width: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "R\$ ",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
                ),
                Text(
                  calcularPrecoCarrinho().toStringAsFixed(2).replaceAll('.', ','),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double tamanhoImagem = 300;
    final quiosque = widget.quiosque;

    return Scaffold(
      extendBodyBehindAppBar: true,

      appBar: CustomAppBar(),

      body: Stack(
        children: [
          SingleChildScrollView(
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
                              .map((item) =>
                                CardItens(
                                  item: item,
                                    // No seu CardItens ou onde o onChanged é chamado:
                                    onChanged: (itemAtualizado) {
                                      setState(() {
                                        // 1. Procura se o item já está no carrinho
                                        int index = ItensAdicionarCarrinho.indexWhere(
                                                (i) => i.nomeItem == itemAtualizado.nomeItem
                                        );

                                        if (index != -1) {
                                          // 2. Se existe e a nova qtd é > 0, atualiza
                                          if (itemAtualizado.qtdItem > 0) {
                                            ItensAdicionarCarrinho[index] = itemAtualizado;
                                          } else {
                                            // 3. Se a qtd chegou a 0, remove da lista
                                            ItensAdicionarCarrinho.removeAt(index);
                                          }
                                        } else if (itemAtualizado.qtdItem > 0) {
                                          // 4. Se não existe e tem qtd, adiciona
                                          ItensAdicionarCarrinho.add(itemAtualizado);
                                        }
                                      });
                                    }
                                )
                          ),

                          if (ItensAdicionarCarrinho.isNotEmpty) SizedBox(height: 90),
                        ],
                      ),
                  ),
                ],
              ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              transitionBuilder: (child, animation) => SlideTransition(
                position: Tween<Offset>(
                  begin: Offset(0, 1),
                  end: Offset(0, 0),
                ).animate(animation),
                child: child,
              ),
              child: ItensAdicionarCarrinho.isNotEmpty
                ? Padding(
                  key: ValueKey('botao'),
                  padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).padding.bottom + 10,
                  left: 16,
                  right: 16,
                  ),
                  child: botaoAdicionar(),
                )
                : SizedBox.shrink(key: ValueKey('vazio')),
              ),
          ),
        ],
      ),

    );
  }
}