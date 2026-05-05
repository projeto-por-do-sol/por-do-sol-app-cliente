import 'package:flutter/material.dart';

class ContainerBusca extends StatefulWidget {
  final Function(String filtro, String ordenacao) trocaFiltro;

  const ContainerBusca({
    super.key,
    required this.trocaFiltro,
  });

  @override
  State<ContainerBusca> createState() => _ContainerBuscaState();
}

class _ContainerBuscaState extends State<ContainerBusca> {
  String nomeClienteTeste = "Osvaldo";
  bool notificacoesNaoVistas = false;
  TextEditingController pesquisaController = TextEditingController();
  String filtroSelecionado = 'distancia';
  String ordencaoSelecionado = 'menor';

  void _notificarMudanca(){
    widget.trocaFiltro(filtroSelecionado, ordencaoSelecionado);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      // height: 50,
      padding: EdgeInsets.fromLTRB(20, 50, 20, 20),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
      ),

      child: Column(
        children: [
            Row(
              children: [

                SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Olá, ${nomeClienteTeste}",
                          style:
                          TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          )

                        ),

                      Text("Qual vai ser hoje?",
                          style:
                          TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                          )
                      ),
                    ],
                  ),
                ),

                Expanded(child: Container()),

                CircleAvatar(
                  radius: 25,
                  backgroundColor: Theme.of(context).colorScheme.tertiary,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                    },
                    icon: Icon(
                      notificacoesNaoVistas
                          ? Icons.notifications_rounded
                          : Icons.notifications_none_rounded,
                      color: Theme.of(context).colorScheme.onPrimary,
                      size: 25,
                      weight: 800,
                    ),
                  ),
                ),

              ],
            ),

          SizedBox(height: 15),

          SizedBox(
            // height: 50,
            child: TextField(
                autocorrect: true,
                textAlignVertical: TextAlignVertical.center,
                controller: pesquisaController,
                // textCapitalization: TextCapitalization.words,
                style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.onSecondary),
                cursorColor: Theme.of(context).colorScheme.secondary,

                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.tertiary,
                  hintText: "Pesquisar",
                  hintStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.onSecondary),

                  prefixIcon: Icon(Icons.search, size: 24, color: Theme.of(context).colorScheme.secondary),

                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),

                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.secondary,
                      width: 2,
                    ),
                  ),
                )
            ),
          ),

          SizedBox(height: 15,),

          Container(
            // margin: EdgeInsets.symmetric(horizontal: 15),
            width: double.infinity,

            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Filtrar por: ",
                  style: Theme.of(context).textTheme.titleSmall,
                ),

                TextButton(
                  style: TextButton.styleFrom(
                    fixedSize: const Size(90, 40),
                    alignment: Alignment.center,
                    padding: EdgeInsets.zero,
                  ),
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    setState(() {
                      filtroSelecionado = filtroSelecionado.toString() == 'distancia' ?
                      'avaliacao' :
                      'distancia';
                    });
                    _notificarMudanca();
                  },
                  child: Text(filtroSelecionado.toString() == 'distancia' ?
                  'Distância' :
                  'Avaliação',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.secondary),
                  ),
                ),

                IconButton(
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    setState(() {
                      ordencaoSelecionado = ordencaoSelecionado.toString() == 'menor' ? 'maior' : 'menor';
                    });
                    _notificarMudanca();
                  },
                  icon: ordencaoSelecionado.toString() == 'menor' ?
                  Icon(Icons.keyboard_arrow_down) : Icon(Icons.keyboard_arrow_up),
                  iconSize: 30,
                  constraints: const BoxConstraints(),
                  padding: const EdgeInsets.all(5),
                  color: Theme.of(context).colorScheme.secondary,
                ),


              ],
            ),

          )
        ],
      ),
    );
  }
}
