import 'package:client_app/providers/carrinho_provider.dart';
import 'package:client_app/src/shared/models/item_carrinho.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CarrinhoPage extends ConsumerStatefulWidget {
  const CarrinhoPage({super.key});

  @override
  ConsumerState<CarrinhoPage> createState() => _CarrinhoPageState();
}

class _CarrinhoPageState extends ConsumerState<CarrinhoPage> {

  Widget identificadorQuiosque(QuiosqueCarrinho quiosque){
    double heightImagem = 80;
    double widthImagem = 90;

    dynamic imagemBanner(){
      return ClipRRect(
        //Tamanho Imagem: 150x90
        // borderRadius: BorderRadius.circular(20),
        borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
        child: quiosque.imgBannerQuiosque != null
            ? Image.network( //TODO: dps tem que trocar por Image.network
          quiosque.imgBannerQuiosque.toString(),
          height: heightImagem,
          width: widthImagem,
          fit: BoxFit.cover,
          // fit: BoxFit.fitWidth,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              height: heightImagem,
              width: widthImagem,
              color: Colors.grey[300],
              child: const Icon(Icons.image_not_supported, color: Colors.grey, size: 40,),
            );
          },
        )
            : Container(
          height: heightImagem,
          width: widthImagem,
          color: Colors.grey[300],
          child: const Icon(Icons.image, color: Colors.grey, size: 40,),
        ),
      );
    }

    return Container(
      margin: EdgeInsets.only(top: 30),
      // padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(10),
      ),

      child: Row(
        children: [

          //TODO: Colocar a imagem do quiosque e alterar o nome do quiosque

          imagemBanner(),

          SizedBox(width: 10,),

          Expanded(
            child: Text(quiosque.nomeQuiosque.toString(),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style:
                TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.onTertiary,
                )
              ,),
          ),
          IconButton(
              onPressed: (){
                ref.read(carrinhoProvider.notifier).removerQuiosque(quiosque);
              },
              icon: Icon(
                Icons.cancel_outlined,
                size: 30,
                color: Theme.of(context).colorScheme.onTertiary,
              )
          ),
        ],
      ),
    );
  }

  Widget itensCarrinho(ItemCarrinho itens, QuiosqueCarrinho quiosque) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              itens.nomeItem,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              'Qtde: ${itens.qtdeItem}',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
          ),

          SizedBox(
            width: 80,
            child: Text(
              'R\$ ${(itens.valorTotal / 100).toStringAsFixed(2).replaceAll('.', ',')}',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
          ),

          IconButton(
            onPressed: () {
              ref.read(carrinhoProvider.notifier).removerItem(quiosque, itens);
            },
            icon: const Icon(
              Icons.delete_forever_outlined,
              color: Colors.black87,
              size: 28,
            ),
          ),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    final carrinho = ref.watch(carrinhoProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Carrinho'),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              ...carrinho.entries.map((entry) {
                var quiosque = entry.key;
                var itens = entry.value;

                return Column(
                  children: [
                    identificadorQuiosque(quiosque),
                    for (var item in itens)
                      itensCarrinho(item, quiosque),
                  ],
                );
              }),

              SizedBox(height: 20,),

            ],
          ),
        ),
      ),
    );
  }
}
