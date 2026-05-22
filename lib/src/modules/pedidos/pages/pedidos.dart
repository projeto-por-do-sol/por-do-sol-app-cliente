import 'package:client_app/providers/pedido_provider/pedido_provider.dart';
import 'package:client_app/src/shared/models/item_carrinho.dart';
import 'package:client_app/src/shared/utils/verificarHorario.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

class PedidosPage extends ConsumerStatefulWidget {
  const PedidosPage({super.key});

  @override
  ConsumerState<PedidosPage> createState() => _PedidosPageState();
}

class _PedidosPageState extends ConsumerState<PedidosPage> {
  Widget identificadorQuiosque(QuiosqueCarrinho quiosque, String status, String horaPedido, String idPedido){
    double heightImagem = 80;
    double widthImagem = 90;

    dynamic imagemBanner(){
      return ClipRRect(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
        child: quiosque.imgBannerQuiosque != null
            ? Image.network(
          quiosque.imgBannerQuiosque.toString(),
          height: heightImagem,
          width: widthImagem,
          fit: BoxFit.cover,
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
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(10),
      ),

      child: Column(
        children: [

          Container(
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
                      showBottomModal(context, status, horaPedido, idPedido);
                    },
                    icon: Icon(
                      Icons.cancel_outlined,
                      size: 30,
                      color: Theme.of(context).colorScheme.onTertiary,
                    )
                ),
              ],
            ),
          ),

          Container(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: Text(status, style:
              TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.outline,
              ),
            ),
          ),

        ],
      ),
    );
  }

  Widget itensCarrinho(ItemCarrinho item, QuiosqueCarrinho quiosque) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),

      decoration: BoxDecoration(
        // color: Colors.white,
        color: Theme.of(context).colorScheme.surface,
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

  Widget caixaCodigoPedido(String codigoPedido){
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(10),
      ),
      width: double.infinity,
      margin: EdgeInsets.only(top: 20, right: 60, left: 60),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(
        children: [
          Text("Código do pedido:",
            style:
              TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Theme.of(context).colorScheme.outline,
              )
          ),

          Text(codigoPedido,
            style:
              TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.outline,
              )
          ),

        ],
      ),
    );
  }

  void showBottomModal(BuildContext context, String statusPedido, String horaPedido, String idPedido) {
    Widget cancelarPedidoEsperando() {
      return SizedBox(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  left: 15,
                  child: Icon(Icons.cancel_outlined, size: 26, color: Theme.of(context).colorScheme.outline),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Text(
                    'deseja cancelar o pedido?'.toUpperCase(),
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Theme.of(context).colorScheme.onTertiary,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    label: const Text('NÃO', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      foregroundColor: Theme.of(context).colorScheme.outline,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    label: const Text('SIM', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    onPressed: () {
                      ref.read(pedidoProvider.notifier).apagarPedidoPorIdPedidoIdQuiosque(idPedido);
                      Navigator.pop(context);
                    },
                  ),
                ),

              ],
            ),
          ],
        ),
      );
    }

    Widget cancelarPrazo30Min(int tempoFaltando){
      return SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  left: 15,
                  child: Icon(Icons.cancel_outlined, size: 26, color: Theme.of(context).colorScheme.outline),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Text(
                    'Poderá cancelar em:'.toUpperCase(),
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),

            Text('$tempoFaltando minutos', style:
              TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(height: 24),

            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.onTertiary,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                label: const Text('OK', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),

          ],
        ),
      );
    }

    Widget cancelarPedidoTempoLimite(){
      return SizedBox(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  left: 15,
                  child: Icon(Icons.cancel_outlined, size: 26, color: Theme.of(context).colorScheme.outline),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Text(
                    'Pedido chegou ao tempo limite.'.toUpperCase(),
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            Text(
              'Deseja cancelar?'.toUpperCase(),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 24),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Theme.of(context).colorScheme.onTertiary,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    label: const Text('NÃO', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      foregroundColor: Theme.of(context).colorScheme.outline,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    label: const Text('SIM', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    onPressed: () {
                      ref.read(pedidoProvider.notifier).apagarPedidoPorIdPedidoIdQuiosque(idPedido);
                      Navigator.pop(context);
                    },
                  ),
                ),

              ],
            ),
          ],
        ),
      );
    }

    var horaVerificada = verificarCancelamentoPedidoHorario(horaPedido);

    showModalBottomSheet(
      backgroundColor: Theme.of(context).colorScheme.surface,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext bc) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: SafeArea(
            child: statusPedido == "Esperando o quiosque aceitar" || statusPedido == "Pedido aceito" ?
            cancelarPedidoEsperando() : horaVerificada[0] ? cancelarPedidoTempoLimite() : cancelarPrazo30Min(horaVerificada[1]),
            // cancelarPedidoEsperando() : horaVerificada[0] ? cancelarPrazo30Min(horaVerificada[1]) : cancelarPedidoTempoLimite(), //TODO: dps tem que tirar, coloquei só para testar o modal
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final pedidos = ref.watch(pedidoProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Pedidos'),
        centerTitle: true,
      ),

      floatingActionButton: FloatingActionButton( //TODO: dps precisa que remover
          onPressed: (){
            ref.read(pedidoProvider.notifier).apagarPedidos();
          }

      ),

      body: pedidos.when(
        loading: () => const Center(child: CircularProgressIndicator()),

        error: (erro, stackTrace) => Center(child: Text("Erro ao carregar pedidos: $erro",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.outline))
        ),

        data: (listaDePedidos) {
          if (listaDePedidos.isEmpty) {
            return Center(child: Text("Nenhum pedido encontrado.",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.outline),));
          }

          final codigoAtual = listaDePedidos.first.codigoPedido;

          return SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  caixaCodigoPedido(codigoAtual),

                  ...listaDePedidos.map((pedido) =>
                      Column(
                        children: [
                          identificadorQuiosque(pedido.quiosque, pedido.status, pedido.horaPedido, pedido.idPedido),
                          for (var item in pedido.itens)
                            itensCarrinho(item, pedido.quiosque),
                        ],
                      )
                  ),

                  SizedBox(height: 20,),
                ],
              ),
            ),
          );
        },
      ),

    );
  }
}
