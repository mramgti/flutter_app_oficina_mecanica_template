import 'package:flutter/material.dart';
import 'package:flutter_app_oficina_mecanica_template/presentation/screen/admin_screen.dart';
import 'package:flutter_app_oficina_mecanica_template/presentation/screen/clientes/clientes_search_screen.dart';
import 'package:flutter_app_oficina_mecanica_template/presentation/screen/endereco/endereco_search_screen.dart';
import 'package:flutter_app_oficina_mecanica_template/presentation/screen/ordem_servico/ordem_servico_search_screen.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  static const String routeName = "homeScreen";
  int _selectedIndex = 0;

  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 115, 185, 243),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: Drawer(child: _drawer(context)),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue[400]!, Colors.blue[200]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.build, size: 100, color: Colors.white),
                SizedBox(height: 20),
                Text(
                  'Bem-vindo à Oficina Mecânica!',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Selecione uma opção no menu lateral.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(206, 255, 255, 255),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _drawer(BuildContext context) {
    return Container(
      color: Colors.blue[400],
      child: ListView(
        children: [
          const DrawerHeader(
            child: Text(
              "Menu",
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            title:
                const Text("Clientes", style: TextStyle(color: Colors.white)),
            leading: const Icon(Icons.people, color: Colors.white),
            onTap: () async {
              _selectedIndex = 0;
              Navigator.pop(context);
              await Navigator.pushNamed(
                  context, ClientesSearchScreen.routeName);
            },
          ),
          ListTile(
            title:
                const Text("Serviços", style: TextStyle(color: Colors.white)),
            selected: _selectedIndex == 1,
            leading: const Icon(Icons.home_repair_service, color: Colors.white),
            onTap: () async {
              _selectedIndex = 1;
              Navigator.pop(context);
              await Navigator.pushNamed(
                  context, OrdemServicoSearchScreen.routeName);
            },
          ),
          ListTile(
            title:
                const Text("Financeiro", style: TextStyle(color: Colors.white)),
            selected: _selectedIndex == 3,
            leading: const Icon(Icons.attach_money, color: Colors.white),
            onTap: () async {
              _selectedIndex = 3;
              Navigator.pop(context);
              await Navigator.pushNamed(
                  context, EnderecoSearchScreen.routeName);
            },
          ),
          ListTile(
            title: const Text("Admin", style: TextStyle(color: Colors.white)),
            selected: _selectedIndex == 4,
            leading: const Icon(Icons.key, color: Colors.white),
            onTap: () async {
              _selectedIndex = 4;
              Navigator.pop(context);
              await Navigator.pushNamed(context, AdminScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}
