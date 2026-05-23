import 'package:client_app/providers/cliente_provider/cliente_provider.dart';
import 'package:client_app/src/shared/widget/button.dart';
import 'package:client_app/src/shared/widget/input.dart';
import 'package:client_app/src/shared/widget/inputImagem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class Cadastro extends ConsumerStatefulWidget {
  const Cadastro({super.key});

  @override
  ConsumerState<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends ConsumerState<Cadastro> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController cpfController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    cpfController.dispose();
    passwordController.dispose();
    passwordConfirmController.dispose();
    super.dispose();
  }

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
                  onPressed: () async {
                    print(cpfController.text);
                    if (passwordController.text != passwordConfirmController.text) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "As senhas não coincidem!".toUpperCase(),
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          backgroundColor: Theme.of(context).colorScheme.primary,
                          duration: Duration(seconds: 3),
                        ),
                      );
                      return;
                    }

                    if (_formKey.currentState!.validate()) {
                      await ref.read(clienteProvider.notifier).login(
                        nomeCompleto: nameController.text.trim(),
                        email: emailController.text.trim(),
                        telefone: phoneController.text.trim(),
                      );
                      if (context.mounted) context.go('/inicio');
                    }
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
