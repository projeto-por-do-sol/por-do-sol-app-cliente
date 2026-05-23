import 'package:client_app/data/services/cliente_service.dart';
import 'package:client_app/providers/carrinho_provider/carrinho_provider.dart';
import 'package:client_app/providers/pedido_provider/pedido_provider.dart';
import 'package:client_app/src/shared/models/cliente_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final clienteProvider =
    AsyncNotifierProvider<ClienteNotifier, ClienteModel?>(ClienteNotifier.new);

class ClienteNotifier extends AsyncNotifier<ClienteModel?> {
  @override
  Future<ClienteModel?> build() async {
    final logado = await ClienteService.instance.estaLogado();
    if (!logado) return null;
    return ClienteService.instance.buscarCliente();
  }

  Future<void> login({
    required String nomeCompleto,
    required String email,
    required String telefone,
    String token = 'mock_jwt_token',
  }) async {
    await ClienteService.instance.salvarJWT(token);
    final cliente = ClienteModel(
      nomeCompleto: nomeCompleto,
      email: email,
      telefone: telefone,
    );
    await ClienteService.instance.salvarCliente(cliente);
    final salvo = await ClienteService.instance.buscarCliente();
    state = AsyncData(salvo);
  }

  Future<void> atualizarPerfil(ClienteModel cliente) async {
    await ClienteService.instance.salvarCliente(cliente);
    final atualizado = await ClienteService.instance.buscarCliente();
    state = AsyncData(atualizado);
  }

  Future<void> logout() async {
    await ClienteService.instance.deletarDadosCliente();
    ref.read(carrinhoProvider.notifier).limparCarrinho();
    ref.read(pedidoProvider.notifier).apagarPedidos();
    state = const AsyncData(null);
  }

  Future<void> deletarConta() async {
    await ClienteService.instance.deletarDadosCliente();
    ref.read(carrinhoProvider.notifier).limparCarrinho();
    ref.read(pedidoProvider.notifier).apagarPedidos();
    state = const AsyncData(null);
  }
}
