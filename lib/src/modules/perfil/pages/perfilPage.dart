import 'package:client_app/src/shared/widget/button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({super.key});

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> { //Precisa criar o model do usuário
  List<List<dynamic>> listaTopicos = [ //TODO: Dps tem que mudar os onPressed
    ['Modificar perfil', '/login', Icons.info_outline],
    ['Histórico de pedidos', '/login', Icons.history_outlined],
    ['Ajuda', '/login', Icons.history_outlined],
    ['Sair', '/login', Icons.logout_outlined],
    ['Excluir conta', '/login', Icons.delete_forever_outlined]
  ];

  dynamic imagemPerfil(){
    double tamanhoImagem = 70.0;
    return ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child:
      // usuario.imgPerfilQuiosque != null
      //     ? Image.network(
      //   usuario.imgPerfilQuiosque.toString(),
      //   height: tamanhoImagem,
      //   width: tamanhoImagem,
      //   fit: BoxFit.cover,
      //   // fit: BoxFit.fitWidth,
      //   errorBuilder: (context, error, stackTrace) {
      //     return Container(
      //       height: tamanhoImagem,
      //       width: tamanhoImagem,
      //       color: Colors.grey[300],
      //       child: const Icon(Icons.person_off, color: Theme.of(context).colorScheme.outline, size: 40,),
      //     );
      //   },
      // ):
      Container(
        height: tamanhoImagem,
        width: tamanhoImagem,
        color: Colors.grey[300],
        child: Icon(Icons.person, color: Theme.of(context).colorScheme.outline, size: 40,),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Perfil"),
        centerTitle: true,
      ),
      
      body: Column(
          children: [

            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: imagemPerfil(),
                  ),

                  Text(
                    "Osvaldo",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSecondary,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            SizedBox(height: 15,),

            Column(
              children: [
                ...listaTopicos.map((topico) =>
                    Column(
                      children: [
                        CustomButton(
                          label: topico[0],
                          onPressed: () {
                            context.push(topico[1]);
                          },
                          icone: topico[2],
                        ),

                        SizedBox(height: 15,),
                      ],
                    ),
                ),



              ],
            ),
          ],
        ),
    );
  }
}
