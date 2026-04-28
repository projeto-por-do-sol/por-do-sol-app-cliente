import 'package:client_app/src/shared/widget/button.dart';
import 'package:client_app/src/shared/widget/input.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
      appBar: AppBar(
        title: Text('ENTRAR'),
        centerTitle: true,
      ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [

                // Container(
                //   alignment: Alignment.center,
                //   margin: const EdgeInsets.fromLTRB(0, 70, 0, 30),
                //   child: CustomTitle(label: "entrar")
                // ),

                const SizedBox(height: 30),

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

                const SizedBox(height: 10),

                TextButton(onPressed: (){
                    // Navigator.pop(context);
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => Cadastro()));
                    context.push('/cadastro');
                  }, child: Text("Cadastrar-se", style: TextStyle(fontSize: 16),)),

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
                          // Navigator.pop(context);
                          // Navigator.push(context, MaterialPageRoute(builder: (context) => Teste()));
                          context.go('/inicio');
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("E-mail/telefone ou senha incorreto(a)!".toUpperCase(), textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w600),),
                                backgroundColor: Theme.of(context).colorScheme.primary,
                                duration: Duration(seconds: 3),
                              )
                          );
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