import 'dart:async';

import 'package:client_app/MyApp.dart';
import 'package:client_app/data/services/notification_service.dart';
import 'package:client_app/providers/pedido_provider/pedido_provider.dart';
import 'package:client_app/src/shared/models/pedidos_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Envolve o app e reage ao TOQUE em uma notificação, navegando para:
///  - `/avaliarPedidos` se o pedido referido estiver cancelado;
///  - `/pedidos` caso contrário.
///
/// Escuta tanto os toques que chegam com o app rodando (stream do
/// [NotificationService]) quanto o toque que abriu o app do estado encerrado.
class NotificacaoListener extends ConsumerStatefulWidget {
  final Widget child;

  const NotificacaoListener({super.key, required this.child});

  @override
  ConsumerState<NotificacaoListener> createState() =>
      _NotificacaoListenerState();
}

class _NotificacaoListenerState extends ConsumerState<NotificacaoListener> {
  StreamSubscription<Map<String, dynamic>>? _sub;

  @override
  void initState() {
    super.initState();

    // Toques com o app já rodando (foreground/background).
    _sub = NotificationService.instance.aoTocarNotificacao.listen(_tratarToque);

    // Toque que abriu o app a partir do estado encerrado: tratamos após o
    // primeiro frame, garantindo que o router já esteja pronto para navegar.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final inicial = NotificationService.instance.consumirToqueInicial();
      if (inicial != null) _tratarToque(inicial);
    });
  }

  Future<void> _tratarToque(Map<String, dynamic> dados) async {
    final idPedido = dados['idPedido'] as String?;

    // Sem id não dá para localizar o pedido: leva para a lista de pedidos.
    if (idPedido == null) {
      appRouter.go('/pedidos');
      return;
    }

    // 1) Procura o pedido na lista local (sqflite via provider).
    final pedidos = await ref.read(pedidoProvider.future);
    PedidosModel? pedido;
    for (final p in pedidos) {
      if (p.idPedido == idPedido) {
        pedido = p;
        break;
      }
    }

    // 2) Não achou localmente -> busca no back-end.
    pedido ??=
        await ref.read(pedidoProvider.notifier).buscarPedidoNoBackend(idPedido);

    final cancelado = pedido != null && pedido.cancelado;

    if (cancelado) {
      appRouter.push('/avaliarPedidos', extra: pedido);
    } else {
      appRouter.go('/pedidos');
    }
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
