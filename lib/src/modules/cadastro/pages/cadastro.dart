import 'package:client_app/src/shared/widget/button.dart';
import 'package:client_app/src/shared/widget/input.dart';
import 'package:client_app/src/shared/widget/inputImagem.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({super.key});

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController cpfController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastro"),
        centerTitle: true,
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 20),

                CustomInput(
                  label: "Nome Completo:",
                  controller: nameController,
                  isRequired: true,
                  typeText: TextCapitalization.words,
                ),

                const SizedBox(height: 15),

                CustomInput(
                  label: "E-mail:",
                  controller: emailController,
                  isRequired: true,
                  isEmail: true,
                ),

                const SizedBox(height: 15),

                CustomInput(
                  label: "Telefone:",
                  controller: phoneController,
                  isRequired: true,
                  isPhone: true,
                ),

                const SizedBox(height: 15),

                CustomInput(
                  label: "CPF:",
                  controller: cpfController,
                  isRequired: true,
                  isCPF: true,
                ),

                const SizedBox(height: 15),

                CustomInput(
                  label: "Senha:",
                  controller: passwordController,
                  isRequired: true,
                  isPassword: true,
                ),

                const SizedBox(height: 15),

                CustomInput(
                  label: "Confirmar senha:",
                  controller: passwordConfirmController,
                  isRequired: true,
                  isPassword: true,
                ),

                const SizedBox(height: 15),

                InputFotoPerfil(),

                const SizedBox(height: 20),

                CustomButton(
                  label: "criar conta",
                  onPressed: () {
                    if (passwordController.text == passwordConfirmController.text) {
                      if (_formKey.currentState!.validate()) {
                        debugPrint("Formulário válido!");
                        // if (loginController == "teste@gmail.com" && passwordController == "123"){
                        //
                        // }
                        context.go('/inicio');
                      } else {
                        debugPrint("Formulário inválido.");
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("As senhas não coincidem!".toUpperCase(), textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w600),),
                            backgroundColor: Theme.of(context).colorScheme.primary,
                            duration: Duration(seconds: 3),
                          )
                      );
                    }

                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      )


    );
  }
}
