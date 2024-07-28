import 'package:flutter/material.dart';
import 'package:flutter_app_oficina_mecanica_template/data/database_provider.dart';
import 'package:flutter_app_oficina_mecanica_template/domain/models/endereco_model.dart';
import 'package:flutter_app_oficina_mecanica_template/domain/repositories/endereco_repository.dart';
import 'package:flutter_app_oficina_mecanica_template/presentation/screen/endereco/endereco_form_screen.dart';
import 'package:flutter_app_oficina_mecanica_template/presentation/widgets/search_widget.dart';

/// Janela responsável por realizar a pesquisa dos endereços e também 
/// possui um botão para chamar a janela de cadastro dos endereços.
class EnderecoSearchScreen extends StatefulWidget {
  /* Definindo o nome da rota para a Janela. Definimos o atributo
  como static para que possamos utilizar o nome da rota sem precisar
  criar a instância da classe. */
  static const String routeName = "endereco";

  const EnderecoSearchScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EnderecoSearchScreenState();
}

class _EnderecoSearchScreenState extends State<EnderecoSearchScreen> {
  /* Armazena os resultados provenientes do banco de dados. Essa lista
  será utilizada para listar os dados no componente ListView. */
  List<Endereco> _results = [];

  DatabaseProvider _databaseProvider = DatabaseProvider();
  late EnderecoRepository _enderecoRepository;

  @override
  void initState() {
    super.initState();
    initDatabase();
  }

  /// Método responsável por abrir a conexão com o banco de dados
  /// e criar a instância da classe EnderecoRepository, consultar
  /// todos os endereços e atribuir o resultado no objeto _results.
  void initDatabase() async {
    await _databaseProvider.open();
    _enderecoRepository = EnderecoRepository(_databaseProvider);
    List<Endereco> res = await _enderecoRepository.findAll();
    setState(() {
      _results = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SearchWidget(
      title: "Endereços",
      routeNameForm: EnderecoFormScreen.routeName,
      results: _results,
      onItemBuilder: (context, index) => _createItem(context, index),
      updateListView: () {
        _buscarTodos();
      },
    );
  }

  /// Método responsável por criar a visualização de cada item da Lista.
  Widget _createItem(BuildContext context, int index) {
    return Card(
      child: ListTile(
        title: Text(_results[index].rua ?? ''),
        subtitle: Text('${_results[index].bairro ?? ''}, ${_results[index].cidade ?? ''}'),
        leading: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () async {
            // Recupera o objeto a ser excluído  
            Endereco endereco = _results[index];

            // Chama o método delete para excluir o registro do banco
            await _enderecoRepository.delete(endereco);

            // Atualiza a lista de pesquisa novamente
            await _buscarTodos();
          },
        ),
        onTap: () async {
          // Recupera o item selecionado da lista
          Endereco endereco = _results[index];

          // O parâmetro arguments é utilizado para enviar dados à janela 
          // que foi chamada pelo método pushNamed.
          await Navigator.of(context).pushNamed(EnderecoFormScreen.routeName,
              arguments: endereco);

          // Atualiza a lista de pesquisa novamente
          await _buscarTodos();
        },
      ),
    );
  }

  Future<void> _buscarTodos() async {
    // Atualiza a lista de pesquisa novamente
    List<Endereco> res = await _enderecoRepository.findAll();
    setState(() {
      _results = res;
    });
  }
}
