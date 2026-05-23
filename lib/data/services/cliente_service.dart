import 'package:client_app/data/repositories/cliente_repository.dart';
import 'package:client_app/src/shared/models/cliente_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:geolocator/geolocator.dart';

class ClienteService {
  static final ClienteService instance = ClienteService._init();

  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  final ClienteRepository _repository = ClienteRepository.instance;

  static const _jwtKey = 'jwt_token';

  ClienteService._init();

  Future<void> salvarJWT(String token) async {
    await _secureStorage.write(key: _jwtKey, value: token);
  }

  Future<String?> obterJWT() async {
    return await _secureStorage.read(key: _jwtKey);
  }

  Future<void> deletarJWT() async {
    await _secureStorage.delete(key: _jwtKey);
  }

  Future<bool> estaLogado() async {
    final token = await obterJWT();
    return token != null && token.isNotEmpty;
  }

  Future<ClienteModel?> buscarCliente() => _repository.buscarCliente();

  Future<void> salvarCliente(ClienteModel cliente) async {
    final existente = await _repository.buscarCliente();
    if (existente == null) {
      await _repository.inserirCliente(cliente);
    } else {
      await _repository.atualizarCliente(cliente.copyWith(id: existente.id));
    }
  }

  Future<void> deletarDadosCliente() async {
    await deletarJWT();
    await _repository.deletarCliente();
  }

  Future<Position?> obterLocalizacao() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return null;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return null;
    }

    if (permission == LocationPermission.deniedForever) return null;

    return await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.medium),
    );
  }
}
