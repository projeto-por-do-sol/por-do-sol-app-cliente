import 'package:client_app/src/shared/widget/button.dart';
import 'package:client_app/src/shared/widget/input.dart';
import 'package:client_app/src/shared/widget/inputImagem.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ModificarPerfilPage extends StatefulWidget {
  const ModificarPerfilPage({super.key});

  @override
  State<ModificarPerfilPage> createState() => _ModificarPerfilPageState();
}

class _ModificarPerfilPageState extends State<ModificarPerfilPage> {
  TextEditingController nameController = TextEditingController(); //TODO: precisa carregar os dados do cliente
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
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

                  InputFotoPerfil(),

                  const SizedBox(height: 20),

                  CustomButton(
                    label: "Salvar",
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        debugPrint("Formulário válido!");
                        // if (loginController == "teste@gmail.com" && passwordController == "123"){
                        //
                        // }
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Alterações salvas".toUpperCase(), textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w600),),
                              backgroundColor: Theme.of(context).colorScheme.primary,
                              duration: Duration(seconds: 3),
                            )
                        );
                        context.go('/perfil');
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Erro ao salvar alterações".toUpperCase(), textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w600),),
                              backgroundColor: Theme.of(context).colorScheme.error,
                              duration: Duration(seconds: 3),
                            )
                        );
                        debugPrint("Formulário inválido.");
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
