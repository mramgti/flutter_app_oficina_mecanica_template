import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {

  //Título do formulário de pesquisa
  String title;  
  
  //Nome da rota do formulário de cadastro a ser chamado
  String routeNameForm;

  //Representa os dados a serem preenchidos na lista de pesquisa
  List<dynamic> results;

  /*Função callback utilizada para criar itens 
  de visualização custimizada para o ListView */
  Widget? Function(BuildContext context, int index) onItemBuilder;

  /*Função callback utilizada para quando queremos atualizar a lista de
  pesquisa.*/
  Function() updateListView; 

  SearchWidget({ Key? key, 
          required this.title,
          required this.routeNameForm,  
          required this.results,
          required this.onItemBuilder,
          required this.updateListView        
          }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(        
        title: Text(title),        
      ),
      body: _body(context),
      floatingActionButton: 
          FloatingActionButton(backgroundColor: Colors.blue[400],
          child: const Icon(Icons.add, color: Colors.white,),
          onPressed: () async{
              await Navigator.pushNamed(context, routeNameForm);
              updateListView();
          },),     
    );
  }

  Widget _body(BuildContext context){
      return Padding(padding: const EdgeInsets.all(16),
        child: Column(
          children: [
              _createSearchTextField(context),
              const SizedBox(height: 16,),
              _createListView(context)
          ]),
      );
  }

  Widget _createSearchTextField(BuildContext context){
      return const Row(children: [
            Flexible(child: 
                TextField(decoration: InputDecoration(
                                  labelText: "Pesquisar...",
                                  suffixIcon: Icon(Icons.search)
                                ),
                        )
                )
        ],
      );
  }

  /// Método responsável por criar a estrutura do listview no qual
  /// exibirá os dados do banco de dados  
  Widget _createListView(BuildContext context){

      if (results.isEmpty)
      {
        return const Text("Sem dados disponíveis", 
            style: TextStyle(fontSize: 20),);
      }
      else
      return Expanded(         
        child : SizedBox(     
              height: 150,
              child: ListView.builder(
                    itemCount: results.length,
                    itemBuilder: onItemBuilder
                  )
              )
      );

  }

}