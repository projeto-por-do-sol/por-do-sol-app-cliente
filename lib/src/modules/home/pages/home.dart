import 'package:client_app/src/modules/home/widget/card_quiosque.dart';
import 'package:client_app/src/modules/home/widget/SearchContainer.dart';
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
  );

  QuiosqueModel quiosque2 = QuiosqueModel(
    nomeQuiosque: "Quiosque 2",
    imgPerfilQuiosque: "logo.png",
    imgBannerQuiosque: "logo.png",
    avalicaoQuiosque: "2,1",
    distanciaQuiosque: "84",
  );

  late List<QuiosqueModel> listaQuiosques = [quiosque1, quiosque2];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Column(
          children: [

            const SizedBox(height: 20),

            SearchContainer(
              onFilterChanged: (filtro, ordenacao) {
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
              }),

            ...listaQuiosques.map((quiosque) {
              return CardQuiosque(
                quiosque: quiosque,
              );
            }),

            const SizedBox(height: 10),

          ],
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