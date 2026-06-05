import 'package:client_app/src/shared/models/item_carrinho.dart';
import 'package:client_app/src/shared/models/pedidos_model.dart';
import 'package:client_app/src/shared/widget/button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StatusPedido {
  static const canceladoQuiosque = 'Cancelado pelo quiosque';
  static const canceladoCliente  = 'Cancelado pelo cliente';
  static const finalizado        = 'Finalizado';
}

class AvaliarPedidos extends StatefulWidget {
  final PedidosModel pedido;

  const AvaliarPedidos({super.key, required this.pedido});

  @override
  State<AvaliarPedidos> createState() => _AvaliarPedidosState();
}

class _AvaliarPedidosState extends State<AvaliarPedidos> {
  int _nota = 0;

  PedidosModel get _pedido => widget.pedido;

  bool get _cancelado =>
      _pedido.status == StatusPedido.canceladoQuiosque ||
      _pedido.status == StatusPedido.canceladoCliente;

  bool get _mostrarMotivo =>
      _pedido.status == StatusPedido.canceladoQuiosque &&
      (_pedido.motivoCancelamento?.trim().isNotEmpty ?? false);

  // Só é possível avaliar pedidos que foram finalizados.
  bool get _podeAvaliar => _pedido.status == StatusPedido.finalizado;

  void _avaliar() {
    final colorScheme = Theme.of(context).colorScheme;
    // if (_nota == 0) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(
    //       content: const Text('Selecione ao menos uma estrela'),
    //       backgroundColor: colorScheme.tertiary,
    //       behavior: SnackBarBehavior.floating,
    //       shape: RoundedRectangleBorder(
    //           borderRadius: BorderRadius.circular(12)),
    //     ),
    //   );
    //   return;
    // }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            'Avaliação de $_nota estrela${_nota > 1 ? "s" : ""} enviada!',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: colorScheme.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Voltar")
      ),
      
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),

                    //Card do pedido
                    _CardPedido(
                      quiosque: _pedido.quiosque.nomeQuiosque,
                      data: DateFormat('dd/MM/yyyy')
                          .format(DateTime.parse(_pedido.horaPedido)),
                      itens: _pedido.itens,
                      status: _pedido.status,
                      cancelado: _cancelado,
                    ),

                    const SizedBox(height: 14),

                    //Avaliação (somente pedidos finalizados)
                    if (_podeAvaliar) ...[
                      //Banner avaliação
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 14),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius: BorderRadius.circular(14),
                          // border: Border.all(color: Theme.of(context).colorScheme.onSecondary),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              _nota > 0
                                  ? Icons.star_rounded
                                  : Icons.star_border_rounded,
                              color: _nota > 0
                                  ? Theme.of(context).colorScheme.onSurface
                                  : Theme.of(context).colorScheme.outline,
                              size: 28,
                            ),
                            const SizedBox(width: 14),
                            Text(
                              'AVALIE SEU PEDIDO',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                                color: Theme.of(context).colorScheme.outline,
                                letterSpacing: 0.8,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 30),

                      //Estrelas
                      _estrelasAvaliacao(
                        context,
                        nota: _nota,
                        onNota: (r) => setState(() => _nota = r),
                      ),

                      const SizedBox(height: 30),
                    ],

                    //Motivo cancelamento
                    if (_mostrarMotivo)
                      _motivoCard(context, motivo: _pedido.motivoCancelamento!),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),

            //Botão Avaliar (somente pedidos finalizados)
            if (_podeAvaliar)
              CustomButton(
                label: 'Avaliar',
                onPressed: _avaliar,
              ),

              SizedBox(height: 20,)

          ],
        ),
      ),
    );
  }
}

class _CardPedido extends StatelessWidget {
  final String quiosque;
  final String data;
  final List<ItemCarrinho> itens;
  final String status;
  final bool cancelado;

  const _CardPedido({
    required this.quiosque,
    required this.data,
    required this.itens,
    required this.status,
    required this.cancelado,
  });

  double get _valorTotal =>
      itens.fold<int>(0, (soma, item) => soma + item.valorTotal) / 100;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(14),
        // border: Border.all(color: Theme.of(context).colorScheme.onSecondary),
      ),
      child: Column(
        children: [
          // Header
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
            child: Row(
              children: [
                Text(quiosque,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).colorScheme.outline)),
                const Spacer(),
                Text(data,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).colorScheme.outline)),
              ],
            ),
          ),

          Divider(height: 1, color: Theme.of(context).colorScheme.outline),

          // Itens
          ...itens.map(
            (item) => Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
              child: Row(
                children: [
                  Expanded(
                    child: Text(item.nomeItem,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).colorScheme.outline)),
                  ),
                  Text(
                    'R\$ ${(item.valorTotal / 100).toStringAsFixed(2).replaceAll('.', ',')}',
                    style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.outline),
                  ),
                ],
              ),
            ),
          ),

          // Preço total do pedido
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              'Valor: R\$ ${_valorTotal.toStringAsFixed(2).replaceAll('.', ',')}',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.outline,
              ),
            ),
          ),

          // Status
          Padding(
            padding: const EdgeInsets.only(bottom: 14, top: 10),
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
              decoration: BoxDecoration(
                color: cancelado
                    ? Theme.of(context).colorScheme.onSecondary.withValues(alpha: 0.4)
                    : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                status,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: cancelado
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.outline,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _estrelasAvaliacao(
  BuildContext context, {
  required int nota,
  required void Function(int) onNota,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: List.generate(5, (i) {

      final filled = i < nota;
      return GestureDetector(
        onTap: () => onNota(i + 1),
        child: AnimatedScale(
          scale: filled ? 1.12 : 1.0,
          duration: const Duration(milliseconds: 120),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Icon(
              filled ? Icons.star_rounded : Icons.star_border_rounded,
              size: 54,
              color: filled ? Theme.of(context).colorScheme.onSurface : Theme.of(context).colorScheme.outline,
            ),
          ),
        ),
      );
    }),
  );
}

Widget _motivoCard(BuildContext context, {required String motivo}) {
  final colorScheme = Theme.of(context).colorScheme;
  return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: colorScheme.onSecondary),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Motivo cancelamento:',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: colorScheme.outline,
                ),
              ),
              const Spacer(),
              Container(
                width: 28,
                height: 4,
                decoration: BoxDecoration(
                  color: colorScheme.outline,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            motivo,
            style: TextStyle(
              fontSize: 13,
              color: colorScheme.outline,
              height: 1.55,
            ),
          ),
        ],
      ),
  );
}