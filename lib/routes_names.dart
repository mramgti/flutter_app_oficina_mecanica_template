import 'package:flutter/material.dart';
import 'package:flutter_app_oficina_mecanica_template/presentation/screen/endereco/endereco_form_screen.dart';
import 'package:flutter_app_oficina_mecanica_template/presentation/screen/endereco/endereco_search_screen.dart';
import 'package:flutter_app_oficina_mecanica_template/presentation/screen/home_screen.dart';
import 'package:flutter_app_oficina_mecanica_template/presentation/screen/clientes/clientes_search_screen.dart';
import 'package:flutter_app_oficina_mecanica_template/presentation/screen/clientes/clientes_form_screen.dart';

class RoutesNames {
  static Map<String, WidgetBuilder> get routesNames => {
        HomeScreen.routeName: (context) => HomeScreen(),
        ClientesSearchScreen.routeName: (context) => ClientesSearchScreen(),
        ClientesFormScreen.routeName: (context) => ClientesFormScreen(),
        EnderecoSearchScreen.routeName: (context) => EnderecoSearchScreen(),
        EnderecoFormScreen.routeName: (context) => EnderecoFormScreen(),
      };
}
