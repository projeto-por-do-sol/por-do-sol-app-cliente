import 'package:client_app/data/repositories/pedido_repository.dart';
import 'package:client_app/src/shared/models/pedidos_model.dart';
import 'dart:convert';
import 'package:client_app/data/services/cliente_service.dart';
import 'package:http/http.dart' as http;

class PedidoService {
  static final PedidoService instance = PedidoService._init();

  final PedidoRepository _repository = PedidoRepository.instance;

  PedidoService._init();

  Future<List<Map<String, dynamic>>> listarPedidos() =>
      _repository.listarPedidos();

  Future<int> inserirItem(Map<String, dynamic> dadosPedido) =>
      _repository.inserirItem(dadosPedido);

  Future<int> atualizarStatus(String idPedido, String novoStatus) =>
      _repository.atualizarStatus(idPedido, novoStatus);

  Future<int> deletarTodosPedidos() => _repository.deletarPedido();

  Future<int> deletarPedidoPorId(String idPedido) =>
      _repository.deletarPedidoIdPedido(idPedido);

  Future<int> finalizarTodosPedidos() => _repository.finalizarTodos();

  /// Busca um pedido específico no back-end.
  /// Usado quando o pedido não está no sqflite local
  /// numa notificação de um pedido que não está mais salvo no aparelho.
  /// Retorna `null` se o pedido não for encontrado.
  Future<PedidosModel?> buscarPedidoNoBackend(String idPedido) async {
    // final jwt = await ClienteService.instance.obterJWT();
    // final res = await http.get(
    //   Uri.parse('$_baseUrl/api/pedidos/$idPedido'),
    //   headers: {'Authorization': 'Bearer $jwt'},
    // );
    //
    // if (res.statusCode == 200) {
    //   return PedidosModel.fromJson(jsonDecode(res.body) as Map<String, dynamic>);
    // }
    // if (res.statusCode == 404) return null;
    // throw Exception('Falha ao buscar pedido (${res.statusCode})');



    // Mock enquanto o back-end não está integrado
    print('[PedidoService] (mock) buscar pedido no backend id=$idPedido');
    return null;
  }
}
