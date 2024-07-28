import 'package:flutter/material.dart';
import 'package:flutter_app_oficina_mecanica_template/presentation/screen/clientes/clientes_search_screen.dart';
import 'package:flutter_app_oficina_mecanica_template/presentation/screen/endereco/endereco_search_screen.dart';

class HomeScreen extends StatelessWidget {
  
  /* Definindo o nome da rota para Janela. Definimos o atributo
  como static para que possamos utilizar o nome da rota sem precisar
  criar a instância da classe. */
  static const String routeName = "/";

  //Define o item selecionado no menu Drawer
  int _selectedIndex = 0;

  HomeScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
                  appBar: AppBar(
            title: const Text('Oficina Mecânica'),
          ),
          drawer: Drawer(
            child: _drawer(context)
            ),
          body: Container(),          
        );
    
  }  
  
  /// Método responsável por criar o menu Drawer 
  /// da aplicação
  Widget _drawer(BuildContext context) {
    return ListView(
      children: [
        const DrawerHeader(child: Text("Home")),
        ListTile(
            title: const Text("Clientes"),
            selected: _selectedIndex == 0,
            leading: const Icon( Icons.people ),
            onTap: () async {
                //Fecha o menu
                _selectedIndex = 0;                
                Navigator.pop(context);
                await Navigator.pushNamed(context, 
                   ClientesSearchScreen.routeName);
            },
        ),
        ListTile( 
          title: const Text("Endereços"),
          selected: _selectedIndex == 1,
          leading: const Icon(Icons.home),
          onTap: () async{
            _selectedIndex = 1;
            //Fecha o menu Drawer antes de chamar a Janela
            Navigator.pop(context);            
            //Chamando a janela utilizando o nome da rota            
            await Navigator.pushNamed(context, EnderecoSearchScreen.routeName);            
          },

        )

      ],

    );
  }

}