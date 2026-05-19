import 'package:client_app/providers/carrinho_provider.dart';
import 'package:client_app/src/shared/models/item_carrinho.dart';
import 'package:client_app/src/shared/widget/CustomDivider.dart';
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

  Widget itensCarrinho(ItemCarrinho item, QuiosqueCarrinho quiosque) {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  item.nomeItem,
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
                  'Qtde: ${item.qtdeItem}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
              ),

              SizedBox(
                width: 80,
                child: Text(
                  'R\$ ${(item.valorTotal / 100).toStringAsFixed(2).replaceAll('.', ',')}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
              ),

              IconButton(
                onPressed: () {
                  ref.read(carrinhoProvider.notifier).removerItem(quiosque, item);
                },
                icon: const Icon(
                  Icons.delete_forever_outlined,
                  color: Colors.black87,
                  size: 28,
                ),
              ),
            ],
          ),

          if(item.ingredientes.isNotEmpty || item.adicionais.isNotEmpty)
            Divider(
              height: 10,

            ),

          if (item.ingredientes.isNotEmpty)
            Container(
              margin: EdgeInsets.only(left: 15, right: 20, top: 10, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Remover:", style:
                      TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).colorScheme.outline,
                      )
                  ),
                  ...item.ingredientes.map((ingrediente) =>
                    Text('• $ingrediente', style:
                      TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).colorScheme.outline,
                      )
                    ),
                  )],
              ),
            ),

          if (item.adicionais.isNotEmpty)
            Container(
              margin: EdgeInsets.only(left: 15, right: 20, top: 10, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Adicionais:", style:
                    TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).colorScheme.outline,
                    )
                  ),
                  ...item.adicionais.map((adicional) => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('• ${adicional.nomeAdicional}', style:
                        TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.outline,
                        )
                      ),

                      Text('R\$ ${(adicional.precoAdicional / 100).toStringAsFixed(2).replaceAll('.', ',')}', style:
                        TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.outline,
                        )
                      )
                    ],
                  )
                )],
              ),
            ),

        ],
      ),
    );
  }

  Widget botaoEnviarPedido(){
    return Container(
      margin: EdgeInsets.only(bottom: 10, left: 20, right: 20),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: (){
          bool sucesso = ref.read(carrinhoProvider.notifier).enviarPedido();
          if (sucesso) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Pedido feito com sucesso!".toUpperCase(), textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                  backgroundColor: Theme.of(context).colorScheme.tertiary,
                  duration: Duration(seconds: 3),
                )
            );

          } else {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Erro ao realizar pedido!".toUpperCase(), textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                  backgroundColor: Theme.of(context).colorScheme.error,
                  duration: Duration(seconds: 3),
                )
            );
          }
        },

        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.onSecondary,

          disabledBackgroundColor: Colors.grey.shade300,
          disabledForegroundColor: Colors.grey.shade600,

          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 2,
        ),

        child: Text("Fazer pedido!", style:
          TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    final carrinho = ref.watch(carrinhoProvider);

    return Scaffold(
      extendBody: true,
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

              SizedBox(height: 80,),

            ],
          ),
        ),
      ),

      bottomNavigationBar: carrinho.isNotEmpty
          ? Container(
        color: Colors.transparent,
        child: botaoEnviarPedido(),
      )
          : null,

    );
  }
}
