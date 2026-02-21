import 'package:flutter/material.dart';

class LogoQuiosque extends StatelessWidget {
  const LogoQuiosque({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: NetworkImage(
            'https://www.estadao.com.br/resizer/v2/5776BB3SUJBFFNFYYDEB673PQQ.jpeg?quality=80&auth=e3574cbc8e7fd6f81aa563d250bf079da0935d5fd4d543a72743c3f54461ceee&width=1075&height=527&smart=true',
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
