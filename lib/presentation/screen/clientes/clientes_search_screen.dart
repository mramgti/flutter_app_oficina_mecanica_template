import 'package:flutter/material.dart';
import 'package:flutter_app_oficina_mecanica_template/data/database_provider.dart';
import 'package:flutter_app_oficina_mecanica_template/domain/models/clientes_model.dart';
import 'package:flutter_app_oficina_mecanica_template/domain/repositories/clientes_repository.dart';
import 'package:flutter_app_oficina_mecanica_template/presentation/screen/clientes/clientes_form_screen.dart';
import 'package:flutter_app_oficina_mecanica_template/presentation/widgets/search_widget.dart';

/// Janela responsável por realizar a pesquisa dos clientes e também 
/// possui um botão para chamar a janela de cadastro dos clientes.
class ClientesSearchScreen extends StatefulWidget {
  /* Definindo o nome da rota para a Janela. Definimos o atributo
  como static para que possamos utilizar o nome da rota sem precisar
  criar a instância da classe. */
  static const String routeName = "clientes";

  const ClientesSearchScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ClientesSearchScreenState();
}

class _ClientesSearchScreenState extends State<ClientesSearchScreen> {
  /* Armazena os resultados provenientes do banco de dados. Essa lista
  será utilizada para listar os dados no componente ListView. */
  List<Clientes> _results = [];

  DatabaseProvider _databaseProvider = DatabaseProvider();
  late ClientesRepository _clientesRepository;

  @override
  void initState() {
    super.initState();
    initDatabase();
  }

  /// Método responsável por abrir a conexão com o banco de dados
  /// e criar a instância da classe ClientesRepository, consultar
  /// todos os clientes e atribuir o resultado no objeto _results.
  void initDatabase() async {
    await _databaseProvider.open();
    _clientesRepository = ClientesRepository(_databaseProvider);
    List<Clientes> res = await _clientesRepository.findAll();
    setState(() {
      _results = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SearchWidget(
      title: "Clientes",
      routeNameForm: ClientesFormScreen.routeName,
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
        title: Text(_results[index].nome ?? ''),
        leading: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () async {
            // Recupera o objeto a ser excluído  
            Clientes cliente = _results[index];

            // Chama o método delete para excluir o registro do banco
            await _clientesRepository.delete(cliente);

            // Atualiza a lista de pesquisa novamente
            await _buscarTodos();
          },
        ),
        onTap: () async {
          // Recupera o item selecionado da lista
          Clientes cliente = _results[index];

          // O parâmetro arguments é utilizado para enviar dados à janela 
          // que foi chamada pelo método pushNamed.
          await Navigator.of(context).pushNamed(ClientesFormScreen.routeName,
              arguments: cliente);

          // Atualiza a lista de pesquisa novamente
          await _buscarTodos();
        },
      ),
    );
  }

  Future<void> _buscarTodos() async {
    // Atualiza a lista de pesquisa novamente
    List<Clientes> res = await _clientesRepository.findAll();
    setState(() {
      _results = res;
    });
  }
}
