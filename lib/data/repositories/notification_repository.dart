import 'dart:convert';
import 'package:http/http.dart' as http;

class NotificationRepository {
  static final NotificationRepository instance = NotificationRepository._init();

  NotificationRepository._init();

  // TODO: definir a base URL do back-end Spring.
  // Sugestão: passar via --dart-define=API_BASE_URL=... e ler aqui:
  // static const String _baseUrl =
  //     String.fromEnvironment('API_BASE_URL', defaultValue: 'http://10.0.2.2:8080');
  // (10.0.2.2 é o host da máquina visto de dentro do emulador Android.)

  /// Registra (ou atualiza) o token FCM deste dispositivo no back-end.
  Future<void> registrarToken({
    required String token,
    required String plataforma,
    required String jwt,
  }) async {
    // -----------------------------------------------------------------------
    // Integração real com o back-end (Spring) — descomente quando a camada
    // HTTP estiver disponível e a base URL configurada:
    //
    // final res = await http.post(
    //   Uri.parse('$_baseUrl/api/dispositivos/registrar'),
    //   headers: {
    //     'Content-Type': 'application/json',
    //     'Authorization': 'Bearer $jwt',
    //   },
    //   body: jsonEncode({'token': token, 'plataforma': plataforma}),
    // );
    //
    // if (res.statusCode != 200) {
    //   throw Exception('Falha ao registrar token (${res.statusCode})');
    // }
    // -----------------------------------------------------------------------

    // Mock enquanto o back-end não está integrado:
    print('[NotificationRepository] (mock) registrar '
        'token=$token plataforma=$plataforma');
  }

  /// Remove o token FCM deste dispositivo no back-end (usado no logout).
  Future<void> removerToken({
    required String token,
    required String jwt,
  }) async {
    // -----------------------------------------------------------------------
    // final res = await http.delete(
    //   Uri.parse('$_baseUrl/api/dispositivos/$token'),
    //   headers: {'Authorization': 'Bearer $jwt'},
    // );
    //
    // if (res.statusCode != 200 && res.statusCode != 204) {
    //   throw Exception('Falha ao remover token (${res.statusCode})');
    // }
    // -----------------------------------------------------------------------

    // Mock enquanto o back-end não está integrado
    print('[NotificationRepository] (mock) remover token=$token');
  }
}
