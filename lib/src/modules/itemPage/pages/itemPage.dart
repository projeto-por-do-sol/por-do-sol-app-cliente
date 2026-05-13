import 'package:client_app/src/modules/itemPage/widget/adicionais.dart';
import 'package:client_app/src/modules/itemPage/widget/removerIngrediente.dart';
import 'package:client_app/src/shared/models/adicionaisItem.dart';
import 'package:client_app/src/shared/models/item_quiosque.dart';
import 'package:client_app/src/shared/widget/CustomDivider.dart';
import 'package:client_app/src/shared/widget/appBar.dart';
import 'package:flutter/material.dart';

/*
 * Classe responsável por criar a página de informações do item.
 */

class ItemPage extends StatefulWidget {
  ItemQuiosque item; //Recebe o item que será exibido na página

  ItemPage({
    super.key,
    required this.item,
  });

  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  double tamanhoImagem = 300; //Tamanho da imagem do item
  int qtdeItem = 1;

  List<AdicionaisItem> _meusAdicionais = [];
  double _precoTotalAdicionais = 0.0;

  double get precoCarrinho => widget.item.precoItem / 100 * qtdeItem + _precoTotalAdicionais;


  dynamic caixaPreco(){ //Criar a caixa de preço do item
    double preco = widget.item.precoItem / 100; //Converte o preço para R$

    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary,
          width: 1,
        )
      ),

      child: Column(
        children: [
          Text("A partir de",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.tertiary,
            ),
          ),
          Text("R\$ ${preco.toStringAsFixed(2).replaceAll('.', ',')}",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.primary,
            ),
          )
        ],
      )
    );
  }

  dynamic alterarQuantidade(){
    removerQuantidade(){
      qtdeItem -= 1;
    }

    adicionarQuantidade(){
      qtdeItem += 1;
    }

    icone(IconData icone, Function funcao){
      bool estaAtivo = !(funcao == removerQuantidade && qtdeItem == 1) &&
          !(funcao == adicionarQuantidade && qtdeItem == 99);

      return IconButton.filled(
        icon: Icon(icone),
          style: IconButton.styleFrom(
            backgroundColor: funcao == removerQuantidade
                ? Theme.of(context).colorScheme.onPrimary
                : Theme.of(context).colorScheme.primary,
            foregroundColor: funcao == removerQuantidade
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.onTertiary,

            disabledBackgroundColor: Color(0xFFF5F5F5),
            disabledForegroundColor: Color(0xFFD0D0D0),
          ),
        constraints: BoxConstraints.tightFor(width: 40, height: 40),
        padding: EdgeInsets.zero,
        iconSize: 30,
        onPressed: estaAtivo ? (){
          setState(() {
            funcao();
          });
        } : null
      );
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary,
          width: 1,
        )
      ),
      alignment: Alignment.centerRight,
      child: SizedBox(
        width: 150,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            icone(Icons.remove, removerQuantidade),

            Spacer(),

            Text(qtdeItem.toString(),
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),

            Spacer(),

            icone(Icons.add, adicionarQuantidade)

          ],
        ),
      ),
    );
  }

  Widget botaoAdicionar() {
    return ElevatedButton(
      onPressed: () {

      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onSecondary,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 2,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Texto Principal
          Text(
            "Adicionar ao carrinho",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),

          // Bloco de Preço
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "R\$ ",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              Text(
                precoCarrinho.toStringAsFixed(2).replaceAll('.', ','),
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var verdeTexto = 0xFF64AFC6;
    var verdeFundo = 0xFFEBF5F0;

    var amareloTexto = 0xff8B6540;
    var amareloDetalhes = 0xFFFDD06A;
    var amareloFundo = 0xFFFFF3DC;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(),
      
      body: SingleChildScrollView(
        child: Column(
          children: [
            //Imagem do Item. Caso não carregue, exibe uma imagem de erro
            SizedBox(
              height: tamanhoImagem,
              width: double.infinity,
              child: Image.network(
                widget.item.imgItem.toString(),
                height: tamanhoImagem,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container( //Imagem de erro
                    height: tamanhoImagem,
                    width: double.infinity,
                    color: Colors.grey[300],
                    child: const Icon(Icons.image_not_supported, color: Colors.grey, size: 40,),
                  );
                },
              ),
            ),

            SizedBox(height: 20,),

            SafeArea(
              top: false,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [

                    //Row engloba o nome do item, descrição e a caixa de preço.
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.item.nomeItem.toString(),
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).colorScheme.outline,
                                ),
                              ),

                              SizedBox(height: 10,),
                              //Quebra o texto caso ultrapasse 4 linhas
                              Text(widget.item.descricaoItem.toString(),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 4,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context).colorScheme.outlineVariant,
                                )
                              ),
                            ]
                          ),
                        ),

                        SizedBox(width: 10,),

                        caixaPreco(),
                      ],
                    ),

                    SizedBox(height: 15),

                    CustomDivider(),

                    SizedBox(height: 15),

                    Row(
                      children: [
                        Text("Ingredientes",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).colorScheme.outline,
                            )

                        ),

                        Spacer(),

                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Theme.of(context).colorScheme.tertiary,
                              width: 1,
                            )
                          ),

                          child: Text("Toque para remover",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).colorScheme.tertiary,
                            )
                          ),
                        ),

                      ],
                    ),
                    // SizedBox(height: 10,),

                    //Lista de ingredientes do item
                    RemoverIngrediente(ingredientes: widget.item.ingredientes),

                    SizedBox(height: 15),

                    CustomDivider(),

                    SizedBox(height: 15),

                    Row(
                      children: [
                        Text("Adicionais",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).colorScheme.outline,
                            )

                        ),

                        Spacer(),

                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(amareloFundo),
                              border: Border.all(
                                color: Color(amareloDetalhes),
                                width: 1,
                              )
                          ),

                          child: Text("Opcional",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Color(amareloTexto),
                              )
                          ),
                        ),
                      ],
                    ),

                    Adicionais(
                        adicionais: widget.item.adicionais,
                        onChanged: (selecionados) {
                          setState(() {
                            _meusAdicionais = selecionados;
                            _precoTotalAdicionais = selecionados.fold(0, (soma, item) => soma + (item.precoAdicional / 100));
                          });
                        }
                    ),

                    SizedBox(height: 15),

                    Row(
                      children: [
                        Expanded(
                          child: Text("Quantidade: ",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).colorScheme.outline,
                            ),
                          ),
                        ),

                        alterarQuantidade(),
                      ],
                    ),

                    SizedBox(height: 15),

                    botaoAdicionar(),

                    SizedBox(height: 15),
                  ],
                ),
              )
            ),

          ],
        ),
      ),
    );
  }
}
