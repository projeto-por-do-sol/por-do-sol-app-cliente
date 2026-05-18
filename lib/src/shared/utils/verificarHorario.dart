bool verificarQuiosqueAberto(String horaAbertura, String horaFechamento) {
  final agora = DateTime.now();

  // Função interna para converter "HH:MM" em um DateTime com a data de hoje
  DateTime extrairHora(String horaString) {
    final partes = horaString.split(':');
    final hora = int.parse(partes[0]);
    final minuto = int.parse(partes[1]);

    return DateTime(agora.year, agora.month, agora.day, hora, minuto);
  }

  try {
    final abertura = extrairHora(horaAbertura);
    var fechamento = extrairHora(horaFechamento);

    // Tratamento caso o quiosque feche de madrugada (ex: abre 18:00 e fecha 02:00)
    if (fechamento.isBefore(abertura)) {
      fechamento = fechamento.add(Duration(days: 1));
    }

    // O quiosque está aberto se o momento atual for depois da abertura E antes do fechamento
    return agora.isAfter(abertura) && agora.isBefore(fechamento);
  } catch (e) {
    // Caso a string venha em formato inválido do banco, evita que o app quebre
    print("Erro ao formatar horas: $e");
    return false;
  }
}