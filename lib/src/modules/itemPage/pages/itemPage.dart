import 'package:client_app/src/modules/itemPage/widget/removerIngrediente.dart';
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

  @override
  Widget build(BuildContext context) {
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
