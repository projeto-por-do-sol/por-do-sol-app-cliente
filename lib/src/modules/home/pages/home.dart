import 'package:client_app/src/modules/home/widget/card-quiosque.dart';
import 'package:client_app/src/modules/home/widget/SearchContainer.dart';
import 'package:client_app/src/modules/login/pages/login.dart';
import 'package:client_app/src/shared/widget/button.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [

          const SizedBox(height: 20),

          SearchContainer(),

          CardQuiosque(),

          const SizedBox(height: 10),

          CardQuiosque(),

          const SizedBox(height: 20),

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