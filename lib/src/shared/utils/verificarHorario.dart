DateTime extrairHora(String horaString, DateTime agora) {
  final partes = horaString.split(':');
  final hora = int.parse(partes[0]);
  final minuto = int.parse(partes[1]);

  return DateTime(agora.year, agora.month, agora.day, hora, minuto);
}

bool verificarQuiosqueAberto(String horaAbertura, String horaFechamento) {
  final agora = DateTime.now();

  try {
    final abertura = extrairHora(horaAbertura, agora);
    var fechamento = extrairHora(horaFechamento, agora);

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

dynamic verificarCancelamentoPedidoHorario(String horarioPedido) {
  final agora = DateTime.now();

  try {
    var pedido = extrairHora(horarioPedido, agora);

    // Ajuste para pedidos feitos antes da meia-noite caso já seja madrugada do dia seguinte
    // Ex: Pedido feito às 23:50 e agora são 00:10.
    if (pedido.isAfter(agora)) {
      pedido = pedido.subtract(const Duration(days: 1));
    }

    // Calcula a diferença entre o momento atual e o horário do pedido
    final diferenca = agora.difference(pedido);

    // Retorna true se passou 30 minutos ou mais
    return [diferenca.inMinutes >= 30, 30 - diferenca.inMinutes];

  } catch (e) {
    print("Erro ao formatar horas ou calcular tempo: $e");
    return false;
  }
}