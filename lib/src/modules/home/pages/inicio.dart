import 'package:client_app/src/modules/home/widget/card_quiosque.dart';
import 'package:client_app/src/modules/home/widget/Container_busca.dart';
import 'package:client_app/src/shared/models/quiosque_model.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  QuiosqueModel quiosque1 = QuiosqueModel(
    nomeQuiosque: "Quiosque 1",
    imgPerfilQuiosque: "logo.png",
    imgBannerQuiosque: "bannerTeste.png",
    avalicaoQuiosque: "4,5",
    distanciaQuiosque: "60",
    disponivelEntrega: false,
  );

  QuiosqueModel quiosque2 = QuiosqueModel(
    nomeQuiosque: "Quiosque 2",
    imgPerfilQuiosque: "logo.png",
    imgBannerQuiosque: "logo.png",
    avalicaoQuiosque: "2,1",
    distanciaQuiosque: "84",
    disponivelEntrega: false,
  );

  QuiosqueModel quiosque3 = QuiosqueModel(
    nomeQuiosque: "Quiosque do Porto",
    imgPerfilQuiosque: "logo.png",
    imgBannerQuiosque: "bannerTeste.png",
    avalicaoQuiosque: "4,8",
    distanciaQuiosque: "12",
    disponivelEntrega: true,
  );

  QuiosqueModel quiosque4 = QuiosqueModel(
    nomeQuiosque: "Quiosque Beira Mar",
    imgPerfilQuiosque: "logo.png",
    imgBannerQuiosque: "bannerTeste.png",
    avalicaoQuiosque: "3,9",
    distanciaQuiosque: "45",
    disponivelEntrega: false,
  );

  QuiosqueModel quiosque5 = QuiosqueModel(
    nomeQuiosque: "Cantinho da Praia",
    imgPerfilQuiosque: "logo.png",
    imgBannerQuiosque: "bannerTeste.png",
    avalicaoQuiosque: "5,0",
    distanciaQuiosque: "5",
    disponivelEntrega: true,
  );

  QuiosqueModel quiosque6 = QuiosqueModel(
    nomeQuiosque: "Quiosque Central",
    imgPerfilQuiosque: "logo.png",
    imgBannerQuiosque: "bannerTeste.png",
    avalicaoQuiosque: "4,2",
    distanciaQuiosque: "110",
    disponivelEntrega: false,
  );

  late List<QuiosqueModel> listaQuiosques = [quiosque1, quiosque2, quiosque3, quiosque4, quiosque5, quiosque6];

  @override
  void initState() {
    super.initState();
    // Ordena a lista pela menor distância assim que o app inicia
    listaQuiosques.sort((a, b) =>
        double.parse(a.distanciaQuiosque!).compareTo(double.parse(b.distanciaQuiosque!))
    );
  }

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
                        listaQuiosques.sort((a, b) => double.parse(a.distanciaQuiosque!).compareTo(double.parse(b.distanciaQuiosque!)));
                      } else {
                        listaQuiosques.sort((a, b) => double.parse(b.distanciaQuiosque!).compareTo(double.parse(a.distanciaQuiosque!)));
                      }
                    } else {
                      if (ordenacao == "menor"){
                        listaQuiosques.sort((a, b) => double.parse(a.avalicaoQuiosque!.replaceAll(',', '.')).compareTo(double.parse(b.avalicaoQuiosque!.replaceAll(',', '.'))));
                      } else {
                        listaQuiosques.sort((a, b) => double.parse(b.avalicaoQuiosque!.replaceAll(',', '.')).compareTo(double.parse(a.avalicaoQuiosque!.replaceAll(',', '.'))));
                      }
                    }
                  });
                }
              ),

              const SizedBox(height: 30,),

            if (listaQuiosques.any((q) => q.disponivelEntrega)) ... [
              Container(
                margin: EdgeInsets.only(left: 20),
                alignment: Alignment.centerLeft,
                child: Text("Disponível entrega",
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
                  .where((quiosque) => quiosque.disponivelEntrega)
                  .map((quiosque) => CardQuiosque(quiosque: quiosque)),
            ],

            if (listaQuiosques.any((q) => !q.disponivelEntrega)) ... [

              if (listaQuiosques.any((q) => q.disponivelEntrega)) ... {
                Divider(
                  color: Theme.of(context).colorScheme.tertiary,
                  thickness: 2,
                  indent: 20,
                  endIndent: 20,
                  height: 20,
                ),

                const SizedBox(height: 20,),
              },

              Container(
                margin: EdgeInsets.only(left: 20),
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
                  .where((quiosque) => !quiosque.disponivelEntrega)
                  .map((quiosque) => CardQuiosque(quiosque: quiosque)),
            ],

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