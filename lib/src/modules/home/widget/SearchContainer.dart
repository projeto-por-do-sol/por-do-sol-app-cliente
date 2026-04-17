import 'package:flutter/material.dart';

class SearchContainer extends StatefulWidget {
  const SearchContainer({super.key});

  @override
  State<SearchContainer> createState() => _SearchContainerState();
}

class _SearchContainerState extends State<SearchContainer> {
  TextEditingController pesquisaController = TextEditingController();
  String? filtroSelecionado = 'distancia';
  String? ordencaoSelecionado = 'menor';

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      // height: 50,
      padding: EdgeInsets.fromLTRB(6, 10, 6, 5),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(10),
      ),

      child: Column(
        children: [
          SizedBox(
            height: 50,
            child: TextField(
                autocorrect: true,
                textAlignVertical: TextAlignVertical.center,
                controller: pesquisaController,
                // textCapitalization: TextCapitalization.words,

                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.secondary,
                  hintText: "Pesquisar",
                  hintStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.w600, color: Colors.grey[500]),

                  suffixIcon: Icon(Icons.search, size: 20, color: Colors.grey[500]),

                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),

                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                )
            ),
          ),

          Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
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
                    setState(() {
                      filtroSelecionado = filtroSelecionado.toString() == 'distancia' ?
                      'avaliacao' :
                      'distancia';
                    });
                  },
                  child: Text(filtroSelecionado.toString() == 'distancia' ?
                  'Distância' :
                  'Avaliação',
                    style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                  ),
                ),

                IconButton(
                  onPressed: () {
                    setState(() {
                      ordencaoSelecionado = ordencaoSelecionado.toString() == 'menor' ? 'maior' : 'menor';
                    });
                  },
                  icon: ordencaoSelecionado.toString() == 'menor' ?
                  Icon(Icons.keyboard_arrow_down) : Icon(Icons.keyboard_arrow_up),
                  iconSize: 30,
                  constraints: const BoxConstraints(),
                  padding: const EdgeInsets.all(5),
                  color: Theme.of(context).colorScheme.primary,
                ),


              ],
            ),

          )
        ],
      ),
    );
  }
}
