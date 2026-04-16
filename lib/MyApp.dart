import 'package:client_app/src/modules/login/pages/login.dart';
import 'package:client_app/src/modules/login/pages/login_email.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const textColor = Color(0xFF3A2E2E);
    // const borderColor = Color(0xFF1D3557);

    return MaterialApp(
      // debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // fontFamily: GoogleFonts.poppins().fontFamily,

        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFFF5DD),
          outline: const Color(0xFF3A2E2E),
          surface: const Color(0xFFFFFCF5),
          primary: const Color(0xFFBD6100),
          secondary: const Color(0xFFEFEFEF),
        ),
        scaffoldBackgroundColor: const Color(0xFFFFF5DD),

        textTheme: GoogleFonts.poppinsTextTheme().copyWith(
          headlineLarge: GoogleFonts.poppins(
            fontSize: 36,
            fontWeight: FontWeight.w600,
            color: textColor,
          ),

          titleLarge: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: textColor,
          ),

          titleMedium: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: textColor,
          ),

          titleSmall: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: textColor,
          ),

        ).apply(
          bodyColor: textColor,
          displayColor: textColor,
        ),

        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFFFFCF5),
          foregroundColor: textColor,
        ),
      ),
      home: const Login(),
    );
  }
}
