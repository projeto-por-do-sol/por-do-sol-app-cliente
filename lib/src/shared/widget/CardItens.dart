import 'package:client_app/src/shared/models/item_quiosque.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CardItens extends StatefulWidget {
  ItemQuiosque item;

  CardItens({
    super.key,
    required this.item,
  });

  @override
  State<CardItens> createState() => _CardItensState();
}

class _CardItensState extends State<CardItens> {

  dynamic imagemBanner(){
    double tamanhoImagem = 90.0;
    return ClipRRect(
      //Tamanho Imagem: 150x90
      // borderRadius: BorderRadius.circular(20),
      borderRadius: BorderRadius.only(topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),
      child: Image.network(
        "https://img.drogaraia.com.br/uploads/2019/12/french-fries-phr3xn9_easy-resize-e1577120471937.jpg",
        height: double.infinity,
        width: tamanhoImagem,
        fit: BoxFit.cover,
        // fit: BoxFit.fitWidth,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            height: double.infinity,
            width: tamanhoImagem,
            color: Colors.grey[300],
            child: const Icon(Icons.image_not_supported, color: Colors.grey, size: 40,),
          );
        },
      )
    );
  }

  dynamic precoItem(){
    double precoItem = widget.item.precoItem.toDouble() / 100;

    return Text(
      "R\$ ${precoItem.toStringAsFixed(2).replaceAll('.', ',')}",
      style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  dynamic alterarQuantidade(){
    removerQuantidade(){
      widget.item.qtdeItem -= 1;
    }

    adicionarQuantidade(){
      widget.item.qtdeItem += 1;
    }

    icone(IconData icone, Function funcao){
      return IconButton.filled(
          icon: Icon(icone),
          style: IconButton.styleFrom(
            backgroundColor: funcao == removerQuantidade ? Theme.of(context).colorScheme.onPrimary : Theme.of(context).colorScheme.primary,
            foregroundColor: funcao == removerQuantidade ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.onTertiary,
          ),
          constraints: BoxConstraints.tightFor(width: 40, height: 40),
          padding: EdgeInsets.zero,
          iconSize: 30,
          onPressed: (){
            setState(() {
              funcao();
            });
          }
      );
    }

    return Container(
      alignment: Alignment.centerRight,
      child: SizedBox(
        width: 150,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            widget.item.qtdeItem > 0 ?  icone(Icons.remove, removerQuantidade) : SizedBox(width: 50,),

            Spacer(),

            Text(widget.item.qtdeItem.toString(),
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // FocusScope.of(context).unfocus();
        context.push('/itemPage', extra: widget.item);
      },

      child: Container(
          margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
          // padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.1),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Theme.of(context).colorScheme.secondary,
              width: 1,
            ),
            color: Theme.of(context).colorScheme.surface,
          ),
          height: 150,
          width: double.infinity,
          child: Row(
            children: [

              imagemBanner(),

              Expanded(
                child: Container(
                  // color: Colors.purple,
                  // width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 2,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              widget.item.nomeItem,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                          ),

                          precoItem(),

                        ],
                      ),

                      Spacer(),

                      Text(widget.item.descricaoItem,
                        style: TextStyle(
                          fontSize: 13,
                          color: Theme.of(context).colorScheme.outline,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),

                      Spacer(),

                      alterarQuantidade(),

                    ],
                  ),
                ),
              ),
            ],
          )
      ),
    );
  }
}
