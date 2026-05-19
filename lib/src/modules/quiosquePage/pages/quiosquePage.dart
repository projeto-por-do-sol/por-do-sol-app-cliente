import 'package:client_app/src/shared/models/adicionaisItem.dart';
import 'package:client_app/src/shared/models/item_carrinho.dart';
import 'package:client_app/src/shared/models/item_quiosque.dart';
import 'package:client_app/src/shared/models/quiosque_model.dart';
import 'package:client_app/src/shared/utils/verificarHorario.dart';
import 'package:client_app/src/shared/widget/CardItens.dart';
import 'package:client_app/src/shared/widget/appBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:client_app/providers/carrinho_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuiosquePage extends ConsumerStatefulWidget {
  final QuiosqueModel quiosque;

  QuiosquePage({
    super.key,
    required this.quiosque,
  });

  @override
  ConsumerState<QuiosquePage> createState() => _QuiosquePageState();
}

class _QuiosquePageState extends ConsumerState<QuiosquePage> {
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
    idItem: "1",
    idQuiosque: "quiosque_01",
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
    idItem: "2",
    idQuiosque: "quiosque_01",
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
    idItem: "3",
    idQuiosque: "quiosque_02",
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
    idItem: "4",
    idQuiosque: "quiosque_01",
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
    idItem: "5",
    idQuiosque: "quiosque_01",
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
    idItem: "6",
    idQuiosque: "quiosque_01",
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
  var corVermelha = 0xffFF5000;
  int precoCarrinho = 0;
  List<ItemCarrinho> _itensAdicionarCarrinho = [];
  Key _cardsKey = UniqueKey();

  dynamic funcionamentoQuiosque(){
    bool quiosqueAberto = verificarQuiosqueAberto(widget.quiosque.horarioAbre, widget.quiosque.horarioFecha);

    return Container(
      height: 30,
      alignment: Alignment.center,
      margin: EdgeInsets.only(right: 10),
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: quiosqueAberto? Color(corVerde) : Color(corVermelha),
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
    bool disponivelPedir = !verificarQuiosqueAberto(widget.quiosque.horarioAbre, widget.quiosque.horarioFecha) || !widget.quiosque.disponivelEntrega;

    calcularQtdItens() {
      int qtdItens = 0;
      for (var item in _itensAdicionarCarrinho) {
        qtdItens += item.qtdeItem;
      }
      return qtdItens;
    }

    calcularPrecoCarrinho() {
      double precoCarrinho = 0;
      for (var item in _itensAdicionarCarrinho) {
        precoCarrinho += item.qtdeItem *
            listaItens
                .firstWhere((element) => element.nomeItem == item.nomeItem)
                .precoItem;
      }
      return precoCarrinho / 100;
    }

    return ElevatedButton(
      onPressed: disponivelPedir ? null : () {
        QuiosqueCarrinho quiosqueCarrinho = QuiosqueCarrinho(
          idQuiosque: widget.quiosque.idQuiosque,
          nomeQuiosque: widget.quiosque.nomeQuiosque,
          imgBannerQuiosque: widget.quiosque.imgBannerQuiosque,
        );

        bool tudoSucesso = true;

        for (var item in _itensAdicionarCarrinho) {
          bool sucessoItem = ref.read(carrinhoProvider.notifier).adicionarItem(quiosqueCarrinho, item);

          if (!sucessoItem) {
            tudoSucesso = false;
          }
        }

        ScaffoldMessenger.of(context).clearSnackBars();

        if (tudoSucesso) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Itens adicionados com sucesso!".toUpperCase(),
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              backgroundColor: Theme.of(context).colorScheme.tertiary,
              duration: const Duration(seconds: 3),
            ),
          );

          setState(() {
            _itensAdicionarCarrinho.clear();
            _cardsKey = UniqueKey();
          });

        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Houve um erro ao adicionar algum itens".toUpperCase(),
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              backgroundColor: Theme.of(context).colorScheme.error,
              duration: const Duration(seconds: 3),
            ),
          );
        }
      },

      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onSecondary,

        disabledBackgroundColor: Theme.of(context).colorScheme.primary,
        disabledForegroundColor: Theme.of(context).colorScheme.onSecondary,

        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 2,
      ),

      child:
      !disponivelPedir ?
      Row(
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
                    // color: Theme.of(context).colorScheme.onSecondary,
                  ),
                ),
                Text(
                  calcularQtdItens() < 2 ? "item" : "itens",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    // color: Theme.of(context).colorScheme.onSecondary,
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
              // color: Theme.of(context).colorScheme.onSecondary,
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
                    // color: Theme.of(context).colorScheme.onSecondary,
                  ),
                ),
                Text(
                  calcularPrecoCarrinho().toStringAsFixed(2).replaceAll('.', ','),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    // color: Theme.of(context).colorScheme.onSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ) :
          Text("Não é possível pedir aqui!", style:
            TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
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
                    key: _cardsKey,
                    top: false,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              containerInfoQuiosque(Icons.hourglass_bottom_rounded, "~${widget.quiosque.tempoEspera} min", "Espera"),
                              containerInfoQuiosque(Icons.location_on_rounded, "${widget.quiosque.distanciaQuiosque}m", "Distância"),
                              containerInfoQuiosque(Icons.access_time_filled_rounded,
                                  verificarQuiosqueAberto(widget.quiosque.horarioAbre, widget.quiosque.horarioFecha) ?
                                  widget.quiosque.horarioFecha :
                                  widget.quiosque.horarioAbre,

                                  verificarQuiosqueAberto(widget.quiosque.horarioAbre, widget.quiosque.horarioFecha) ?
                                  "Fecha" : "Abre"),
                            ]
                          ),

                          SizedBox(height: 20,),

                          ...listaItens
                              .where((item) => item.disponivel)
                              .map((item) =>
                                CardItens(
                                  desabilitado: !verificarQuiosqueAberto(widget.quiosque.horarioAbre, widget.quiosque.horarioFecha),
                                  item: item,
                                    quiosque: QuiosqueCarrinho(
                                        idQuiosque: widget.quiosque.idQuiosque,
                                        nomeQuiosque: widget.quiosque.nomeQuiosque,
                                        imgBannerQuiosque: widget.quiosque.imgBannerQuiosque
                                    ),
                                    // No seu CardItens ou onde o onChanged é chamado:
                                    onChanged: (itemAtualizado) {
                                      setState(() {
                                        // 1. Procura se o item já está no carrinho
                                        int index = _itensAdicionarCarrinho.indexWhere(
                                                (i) => i.nomeItem == itemAtualizado.nomeItem
                                        );

                                        if (index != -1) {
                                          // 2. Se existe e a nova qtd é > 0, atualiza
                                          if (itemAtualizado.qtdeItem > 0) {
                                            _itensAdicionarCarrinho[index] = itemAtualizado;
                                          } else {
                                            // 3. Se a qtd chegou a 0, remove da lista
                                            _itensAdicionarCarrinho.removeAt(index);
                                          }
                                        } else if (itemAtualizado.qtdeItem > 0) {
                                          // 4. Se não existe e tem qtd, adiciona
                                          _itensAdicionarCarrinho.add(itemAtualizado);
                                        }
                                      });
                                    }
                                )
                          ),

                          if (_itensAdicionarCarrinho.isNotEmpty) SizedBox(height: 90),
                        ],
                      ),
                  ),
                ],
              ),
          ),
          Positioned( //Dps da pra mudar por bottomNavigationBar, igual na página do carrinho.
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
              child: _itensAdicionarCarrinho.isNotEmpty
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