import 'package:client_app/src/shared/widget/button.dart';
import 'package:client_app/src/shared/widget/input.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController loginController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [

                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.fromLTRB(0, 50, 0, 30),
                  child: Text("ENTRAR", style: Theme.of(context).textTheme.headlineLarge),
                ),

                Image.asset('assets/images/logo.png', width: 200),

                const SizedBox(height: 30),

                CustomInput(
                  label: "E-mail / Telefone:",
                  controller: loginController,
                  isRequired: true,
                  isPhoneOrEmail: true,
                ),

                const SizedBox(height: 30),

                CustomInput(
                  label: "Senha:",
                  controller: passwordController,
                  isRequired: true,
                  isPassword: true,
                ),

                const SizedBox(height: 10),

                Container(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  child: CustomButton(
                    label: "PRÓXIMO",
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        debugPrint("Formulário válido!");
                        debugPrint("E-mail: ${loginController.text}");
                        debugPrint("Senha: ${passwordController.text}");
                      } else {
                        debugPrint("Formulário inválido.");
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}