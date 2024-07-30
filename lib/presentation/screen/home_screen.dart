import 'package:flutter/material.dart';
import 'package:flutter_app_oficina_mecanica_template/presentation/screen/clientes/clientes_search_screen.dart';
import 'package:flutter_app_oficina_mecanica_template/presentation/screen/endereco/endereco_search_screen.dart';

class HomeScreen extends StatelessWidget {
  /* Definindo o nome da rota para Janela. Definimos o atributo
  como static para que possamos utilizar o nome da rota sem precisar
  criar a instância da classe. */
  static const String routeName = "homeScreen";

  //Define o item selecionado no menu Drawer
  int _selectedIndex = 0;

  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Oficina Mecânica'),
      ),
      drawer: Drawer(child: _drawer(context)),
      body: Container(),
    );
  }

  /// Método responsável por criar o menu Drawer
  /// da aplicação
  Widget _drawer(BuildContext context) {
    return Container(
      color: Colors.blue[400], // Substitua pela cor desejada
      child: ListView(
        children: [
          const DrawerHeader(
            child: Text(
              "Menu",
              style: TextStyle(color: Colors.white),
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
                  context, EnderecoSearchScreen.routeName);
            },
          ),
          ListTile(
            title:
                const Text("Endereços", style: TextStyle(color: Colors.white)),
            selected: _selectedIndex == 2,
            leading: const Icon(Icons.location_on, color: Colors.white),
            onTap: () async {
              _selectedIndex = 2;
              Navigator.pop(context);
              await Navigator.pushNamed(
                  context, EnderecoSearchScreen.routeName);
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
            leading: const Icon(
              Icons.key,
              color: Colors.white,
            ),
            onTap: () async {
              _selectedIndex = 4;
              Navigator.pop(context);
              await Navigator.pushNamed(
                  context, EnderecoSearchScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}
