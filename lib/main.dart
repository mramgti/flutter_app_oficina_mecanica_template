import 'package:flutter/material.dart';
import 'package:flutter_app_oficina_mecanica_template/presentation/screen/home_screen.dart';
import 'package:flutter_app_oficina_mecanica_template/presentation/screen/clientes/clientes_search_screen.dart';
import 'package:flutter_app_oficina_mecanica_template/presentation/screen/clientes/clientes_form_screen.dart';
import 'package:flutter_app_oficina_mecanica_template/presentation/screen/intro_screen.dart';
import 'package:flutter_app_oficina_mecanica_template/routes_names.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(  
      debugShowCheckedModeBanner: false,   
      initialRoute: IntroScreen.routeName, // Define a rota principal
      routes: RoutesNames.routesNames, // Define as rotas da aplicação
    );
  }
}
