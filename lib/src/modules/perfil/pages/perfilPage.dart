import 'package:client_app/src/shared/widget/button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({super.key});

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Perfil"),
        centerTitle: true,
      ),
      
      body: Center(
        child: CustomButton(
              label: "voltar login",
              onPressed: () {
                context.push('/login');
              },
            ),
        ),
    );
  }
}
