import 'package:client_app/src/modules/login/pages/login.dart';
import 'package:client_app/src/shared/widget/button.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController pesquisaController = TextEditingController();
  String? filtroSelecionado = 'distancia';
  String? ordencaoSelecionado = 'menor';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [

          const SizedBox(height: 20),

          Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              // height: 50,
              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(10),
              ),

              child: Column(
                children: [
                  SizedBox(
                    height: 35,
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
                          hintStyle: Theme.of(context).textTheme.titleSmall,

                          suffixIcon: Icon(Icons.search, size: 20,),

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
                            fixedSize: const Size(80, 40),
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
                            'Avaliação'
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
                          constraints: const BoxConstraints(),
                          padding: const EdgeInsets.all(5),
                          color: Theme.of(context).colorScheme.primary,
                        ),

                          // TextButton.icon(onPressed: (){}, label: Icon(Icons.arrow_circle_down),
                          //   iconAlignment: IconAlignment.start,
                          //   style: TextButton.styleFrom(
                          //     minimumSize: Size.zero,
                          //     padding: EdgeInsets.zero,
                          //     tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          //   ),
                          // ),
                        
                        // TextButton(onPressed: () {
                        //   showModalBottomSheet(
                        //       context: context,
                        //       builder: (BuildContext context) {
                        //         return Container(
                        //           height: 200,
                        //         );
                        //       });
                        // }, child: Text("Distância"))


                        // Container(
                        //   child: DropdownButtonHideUnderline(
                        //       child: DropdownButton<String>(
                        //         value: filtroSelecionado,
                        //         isExpanded: false,
                        //         style: Theme.of(context).textTheme.titleSmall,
                        //         items: const [
                        //           DropdownMenuItem(
                        //             value: 'distancia',
                        //             child: Text('Distância'),
                        //           ),
                        //           DropdownMenuItem(
                        //             value: 'avaliacao',
                        //             child: Text('Avaliação'),
                        //           ),
                        //         ],
                        //         onChanged: (String? newValue) {
                        //           setState(() {
                        //             filtroSelecionado = newValue;
                        //           });
                        //         }),
                        //
                        //   ),
                        // ),

                        // DropdownMenu<String>(
                        //   initialSelection: filtroSelecionado,
                        //   width: 130,
                        //   trailingIcon: const Icon(Icons.keyboard_arrow_down, size: 18),
                        //   selectedTrailingIcon: const Icon(Icons.keyboard_arrow_up, size: 18),
                        //   textStyle: Theme.of(context).textTheme.titleSmall,
                        //
                        //   inputDecorationTheme: const InputDecorationTheme(
                        //     isDense: true,
                        //     isCollapsed: true,
                        //     contentPadding: EdgeInsets.only(right: -10),
                        //     border: InputBorder.none,
                        //   ),
                        //
                        //   onSelected: (String? newValue) {
                        //     setState(() {
                        //       filtroSelecionado = newValue;
                        //     });
                        //   },
                        //   dropdownMenuEntries: const [
                        //     DropdownMenuEntry(value: 'distancia', label: 'Distância'),
                        //     DropdownMenuEntry(value: 'avaliacao', label: 'Avaliação'),
                        //   ],
                        // ),
                      ],
                    ),

                  )
                ],
              ),
          ),

        CustomButton(
            label: "voltar login",
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
            }),

        ],
      ),
    );
  }
}
