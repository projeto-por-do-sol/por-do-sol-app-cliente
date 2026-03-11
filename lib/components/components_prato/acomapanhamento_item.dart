import 'package:app_por_sol/model/acompanhamento.dart';
import 'package:app_por_sol/model/item.dart';
import 'package:app_por_sol/model/pedido.dart';
import 'package:app_por_sol/screens/prato.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';

class AcomapanhamentoItem extends StatelessWidget {
  final Acompanhamento acompanhamento;
  const AcomapanhamentoItem({required this.acompanhamento});

  // void _itemSelecionado(BuildContext context) {
  //   Navigator.of(
  //     context,
  //   ).push(MaterialPageRoute(builder: (ctx) => Prato(pratoSelecionado: item)));
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
      child: InkWell(
        onTap: () => null,
        child: ListTile(
          title: Text(
            acompanhamento.nomeAcompanhamento,
            style: TextStyle(
              color: Colors.blue[900],
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: ClipRRect(
            child: Image.network(
              'https://www.estadao.com.br/resizer/v2/5776BB3SUJBFFNFYYDEB673PQQ.jpeg?quality=80&auth=e3574cbc8e7fd6f81aa563d250bf079da0935d5fd4d543a72743c3f54461ceee&width=1075&height=527&smart=true',
              height: 50,
              width: 60,
              fit: BoxFit.cover,
            ),
          ),
          trailing: Text("data"),
        ),
      ),
    );
  }
}
