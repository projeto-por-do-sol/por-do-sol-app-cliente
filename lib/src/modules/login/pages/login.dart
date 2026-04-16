import 'package:client_app/src/modules/cadastro/pages/cadastro.dart';
import 'package:client_app/src/modules/home/pages/home.dart';
import 'package:client_app/src/shared/widget/button.dart';
import 'package:client_app/src/shared/widget/input.dart';
import 'package:client_app/src/shared/widget/title.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController loginController = TextEditingController(text: "teste@gmail.com");
  TextEditingController passwordController = TextEditingController(text: "123");
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [

                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.fromLTRB(0, 70, 0, 30),
                  child: CustomTitle(label: "entrar")
                ),

                Image.asset('assets/images/logo.png', width: 180),

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

                Container(
                  child: TextButton(onPressed: (){
                    // Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Cadastro()));
                  }, child: Text("Cadastrar-se", style: TextStyle(fontSize: 16),)),
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
                        if (loginController.text.trim() == "teste@gmail.com" && passwordController.text.trim() == "123"){
                          Navigator.pop(context);
                          Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                        }
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
      );
  }
}