import 'package:client_app/src/modules/cadastro/pages/cadastro.dart';
import 'package:client_app/src/modules/carrinho/pages/carrinho.dart';
import 'package:client_app/src/modules/home/pages/inicio.dart';
import 'package:client_app/src/modules/login/pages/login.dart';
import 'package:client_app/src/modules/pedidos/pages/pedidos.dart';
import 'package:client_app/src/shared/widget/CustomNavBar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'src/modules/perfil/pages/perfilPage.dart';
import 'src/modules/quiosquePage/pages/quiosquePage.dart';
import 'src/shared/models/quiosque_model.dart';

final GoRouter _router = GoRouter(
  initialLocation: '/inicio',
  routes: <RouteBase>[
    //Colocar as páginas que não terão na navBar
    GoRoute(
      path: '/login',
      builder: (context, state) => const Login(),
    ),

    GoRoute(
      path: '/cadastro',
      builder: (context, state) => Cadastro(),
    ),

    GoRoute(
      path: '/quiosquePage',
      builder: (context, state) {
        final quiosque = state.extra as QuiosqueModel;
        return QuiosquePage(quiosque: quiosque);
      },
    ),

    //Links do navBar
    StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell){
          return CustomNavBar(navigationShell: navigationShell);
        },
        branches:[
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/inicio',
                builder: (context, state) => HomePage(),
              ),
            ],
          ),

          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/carrinho',
                builder: (context, state) => CarrinhoPage(),
              ),
            ],
          ),

          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/pedidos',
                builder: (context, state) => PedidosPage(),
              ),
            ],
          ),

          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/perfil',
                builder: (context, state) => PerfilPage(),
              ),
            ],
          ),

        ]
    ),
  ]
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const textColor = Color(0xFF3A2E2E);
    // const borderColor = Color(0xFF1D3557);

    return MaterialApp.router(
      routerConfig: _router,
      title: "Pôr-do-Sol",
      // initialRoute: '/',
      // routes: {
      //   '/quiosquePage': (context) => QuiosquePage(),
      //   '/perfil' : (context) => PerfilPage(),
      // },
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
        // scaffoldBackgroundColor: const Color(0xFFFFF5DD),
        scaffoldBackgroundColor: const Color(0xffFDE8DA),
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
            fontSize: 16,
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
      // home: const HomePage(),
    );
  }
}
