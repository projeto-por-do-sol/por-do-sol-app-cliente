import 'dart:async';

import 'package:app_por_sol/components/components_prato/acomapanhamento_item.dart';
import 'package:app_por_sol/components/components_utils/app_bar_generic.dart';
import 'package:app_por_sol/model/acompanhamento.dart';
import 'package:app_por_sol/model/item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:permission_handler/permission_handler.dart';

class Prato extends StatefulWidget {
  Item pratoSelecionado;
  Prato({required this.pratoSelecionado});

  @override
  State<Prato> createState() => PratotState();
}

class PratotState extends State<Prato> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 193,
              pinned: false,
              floating: false,
              backgroundColor: Colors.transparent,
              elevation: 0,
              flexibleSpace: LayoutBuilder(
                builder: (context, constraints) {
                  final double alturaAtual = constraints.maxHeight;
                  final double percentual =
                      (alturaAtual - kToolbarHeight) / (250 - kToolbarHeight);

                  return Stack(
                    fit: StackFit.expand,
                    clipBehavior: Clip.none,
                    children: [
                      Image.network(
                        height: double.infinity,
                        width: double.infinity,
                        'https://www.estadao.com.br/resizer/v2/5776BB3SUJBFFNFYYDEB673PQQ.jpeg?quality=80&auth=e3574cbc8e7fd6f81aa563d250bf079da0935d5fd4d543a72743c3f54461ceee&width=1075&height=527&smart=true',
                      ),

                      Positioned(
                        bottom: 0,
                        left: 1,
                        right: 1,
                        child: Transform.translate(
                          offset: Offset(0, 30),
                          child: Card(
                            child: Text(
                              widget.pratoSelecionado.descricaoPrato +
                                  'asdhahsbdhabshdbahsbdhbahsbdhabshdbahsbdhbahsbdhabshdbahsbdhasbdhabshdbahbsdbhabhsdbhabshdbhasbdhabhsbdhabsdhbahsbdhasbdhbahsbd',
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),

            SliverList(
              delegate: SliverChildListDelegate([
                SizedBox(height: 60),
                Text(
                  "Molhos",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
                ...widget.pratoSelecionado.list_acompanhamentos.map(
                  (acomp) => AcomapanhamentoItem(acompanhamento: acomp),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
