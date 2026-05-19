
import 'package:client_app/src/modules/inicio/widget/Container_busca.dart';
import 'package:client_app/src/modules/inicio/widget/card_quiosque.dart';
import 'package:client_app/src/shared/models/quiosque_model.dart';
import 'package:client_app/src/shared/utils/verificarHorario.dart';
import 'package:client_app/src/shared/widget/CustomDivider.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  QuiosqueModel quiosque1 = QuiosqueModel(
    idQuiosque: "1", // Adicionado
    nomeQuiosque: "Quiosque 1",
    imgPerfilQuiosque: "logo.png",
    imgBannerQuiosque: "bannerTeste.png",
    avaliacaoQuiosque: 4.5,
    distanciaQuiosque: "60",
    disponivelEntrega: false,
    tempoEspera: 30,
    categorias: ["Lanches", "Bebidas"],
    horarioAbre: "09:00",
    horarioFecha: "18:00",
  );

  QuiosqueModel quiosque2 = QuiosqueModel(
    idQuiosque: "2", // Adicionado
    nomeQuiosque: "Quiosque 2",
    imgPerfilQuiosque: "logo.png",
    imgBannerQuiosque: "logo.png",
    avaliacaoQuiosque: 2.1,
    distanciaQuiosque: "84",
    disponivelEntrega: false,
    tempoEspera: 45,
    categorias: ["Porções", "Cervejas"],
    horarioAbre: "11:00",
    horarioFecha: "23:00",
  );

  QuiosqueModel quiosque3 = QuiosqueModel(
    idQuiosque: "3", // Adicionado
    nomeQuiosque: "Quiosque do Porto Teste aleatório Teste aleatório 2.0",
    imgPerfilQuiosque: "logo1.png",
    imgBannerQuiosque: "bannerTeste1.png",
    avaliacaoQuiosque: 4.8,
    distanciaQuiosque: "12",
    disponivelEntrega: true,
    tempoEspera: 15,
    categorias: ["Frutos do Mar", "Bebidas"],
    horarioAbre: "04:00",
    horarioFecha: "22:00",
  );

  QuiosqueModel quiosque4 = QuiosqueModel(
    idQuiosque: "4", // Adicionado
    nomeQuiosque: "Quiosque Beira Mar",
    avaliacaoQuiosque: 3.9,
    distanciaQuiosque: "45",
    disponivelEntrega: false,
    tempoEspera: 25,
    categorias: ["Lanches", "Sucos Naturais"],
    horarioAbre: "05:00",
    horarioFecha: "21:00",
  );

  QuiosqueModel quiosque6 = QuiosqueModel(
    idQuiosque: "6", // Adicionado
    nomeQuiosque: "Quiosque Central",
    imgPerfilQuiosque: "logo.png",
    imgBannerQuiosque: "bannerTeste.png",
    avaliacaoQuiosque: 4.2,
    distanciaQuiosque: "110",
    disponivelEntrega: false,
    tempoEspera: 40,
    categorias: ["Pratos Feitos", "Sobremesas"],
    horarioAbre: "10:00",
    horarioFecha: "22:00",
  );

  QuiosqueModel quiosque5 = QuiosqueModel(
    idQuiosque: "5", // Adicionado
    nomeQuiosque: "Cantinho da Praia",
    imgPerfilQuiosque: "https://www.guiaviagensbrasil.com/imagens/quiosque-praia-monguaga-sp.jpg",
    imgBannerQuiosque: "https://www.guiaviagensbrasil.com/imagens/quiosque-praia-monguaga-sp.jpg",
    avaliacaoQuiosque: 5.0,
    distanciaQuiosque: "5",
    disponivelEntrega: true,
    tempoEspera: 20,
    categorias: ["Lanches", "Porções", "Bebidas", "Outros"],
    horarioAbre: "10:00",
    horarioFecha: "22:00",
  );

  late List<QuiosqueModel> listaQuiosques = [quiosque1, quiosque2, quiosque3, quiosque4, quiosque5, quiosque6];

  @override
  void initState() {
    super.initState();
    // Ordena a lista pela menor distância assim que o app inicia
    listaQuiosques.sort((a, b) =>
        double.parse(a.distanciaQuiosque).compareTo(double.parse(b.distanciaQuiosque))
    );
  }
  //TODO: Dps da pra mudar a lógica dos quiosques por um Riverpod
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
              children: [

                // const SizedBox(height: 20),

                ContainerBusca(
                    trocaFiltro: (filtro, ordenacao) {
                    setState(() {
                      if (filtro == "distancia"){
                        if (ordenacao == "menor"){
                          listaQuiosques.sort((a, b) => double.parse(a.distanciaQuiosque).compareTo(double.parse(b.distanciaQuiosque)));
                        } else {
                          listaQuiosques.sort((a, b) => double.parse(b.distanciaQuiosque).compareTo(double.parse(a.distanciaQuiosque)));
                        }
                      } else {
                        if (ordenacao == "menor"){
                          listaQuiosques.sort((a, b) => a.avaliacaoQuiosque.compareTo(b.avaliacaoQuiosque));
                        } else {
                          listaQuiosques.sort((a, b) => b.avaliacaoQuiosque.compareTo(a.avaliacaoQuiosque));
                        }
                      }
                    });
                  }
                ),

                const SizedBox(height: 30,),

              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    if (listaQuiosques.any((q) => q.disponivelEntrega
                    //&& verificarQuiosqueAberto(q.horarioAbre, q.horarioFecha) //TODO: Dps tem que remover (exibe a label "Entrega aí" somente se tiver algum quiosque aberto)
                    )) ... [
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text("Entrega aí",
                            style:
                            TextStyle(
                              color: Theme.of(context).colorScheme.outline,
                              fontWeight: FontWeight.w800,
                              fontSize: 20,
                            )
                        ),
                      ),

                      const SizedBox(height: 10,),

                      ...listaQuiosques
                          .where((quiosque) => quiosque.disponivelEntrega
                          // && verificarQuiosqueAberto(quiosque.horarioAbre, quiosque.horarioFecha) //TODO: Dps tem que remover (apenas mostra os quiosques que estão abertos)
                          )
                          .map((quiosque) => CardQuiosque(quiosque: quiosque)),
                    ],

                    if (listaQuiosques.any((q) => !q.disponivelEntrega
                    // && verificarQuiosqueAberto(q.horarioAbre, q.horarioFecha) //TODO: Dps tem que remover (exibe a label "Não entrega aí" somente se tiver algum quiosque aberto)
                    )) ... [

                      if (listaQuiosques.any((q) => q.disponivelEntrega
                      && verificarQuiosqueAberto(q.horarioAbre, q.horarioFecha)
                      )) ... {
                        CustomDivider(),

                        const SizedBox(height: 20,),
                      },

                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text("Não entrega aí",
                            style:
                            TextStyle(
                              color: Theme.of(context).colorScheme.outline,
                              fontWeight: FontWeight.w800,
                              fontSize: 20,
                            )
                        ),
                      ),

                      const SizedBox(height: 10,),

                      ...listaQuiosques
                          .where((quiosque) => !quiosque.disponivelEntrega
                          // && verificarQuiosqueAberto(quiosque.horarioAbre, quiosque.horarioFecha) //TODO: Dps tem que remover (apenas mostra os quiosques que estão abertos)
                          )
                          .map((quiosque) => CardQuiosque(quiosque: quiosque)),
                    ],
                  ]
                ),
              ),



              ],
            ),
          ),
        ),
    );
  }
}


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