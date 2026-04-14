import 'package:client_app/src/shared/widget/button.dart';
import 'package:client_app/src/shared/widget/input.dart';
import 'package:flutter/material.dart';

class LoginEmail extends StatefulWidget {
  const LoginEmail({super.key});

  @override
  State<LoginEmail> createState() => _LoginEmailState();
}

class _LoginEmailState extends State<LoginEmail> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.all(50),
                  child: Text("ENTRAR", style: Theme.of(context).textTheme.headlineLarge),
                ),
                Image.asset('assets/images/logo.png', width: 200),
                const SizedBox(height: 60),
                InputCustom(label: "E-mail / Telefone:"),
                const SizedBox(height: 10),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  child: ButtonCustom(
                    label: "PRÓXIMO",
                    onPressed: () {
                      debugPrint("Clicado");
                    },
                  ),
                ),
              ],
            ),
          )
      )
    );
  }
}
