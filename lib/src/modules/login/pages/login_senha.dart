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
        body: Column(
          children: [
          Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.all(50),
          child: Text("SENHA", style: Theme.of(context).textTheme.headlineLarge),
        ),
        Container(
          child: Image.asset('assets/images/logo.png', width: 200),
        ),
        const SizedBox(height: 60),
        Container(
            child: input(label: "E-mail/Telefone:")
        ),
        const SizedBox(height: 20),
        Container(
          child: ButtonCustom(
            label: "ENTRAR",
            onPressed: () => Navigator.pushNamed(context, '/home'),
          ),
        ),
      ],
    )
    )
    );
  }
}

