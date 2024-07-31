import 'package:flutter/material.dart';
import 'package:flutter_app_oficina_mecanica_template/data/database_provider.dart';
import 'package:flutter_app_oficina_mecanica_template/domain/models/clientes_model.dart';
import 'package:flutter_app_oficina_mecanica_template/domain/repositories/clientes_repository.dart';
import 'package:flutter_app_oficina_mecanica_template/presentation/screen/clientes/clientes_form_screen.dart';
import 'package:flutter_app_oficina_mecanica_template/presentation/screen/clientes/endereco_form_screen.dart';
import 'package:flutter_app_oficina_mecanica_template/presentation/screen/clientes/veiculos_form_screen.dart';
import 'package:flutter_app_oficina_mecanica_template/presentation/widgets/search_widget.dart';

class ClientesSearchScreen extends StatefulWidget {
  static const String routeName = "clientes";

  const ClientesSearchScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ClientesSearchScreenState();
}

class _ClientesSearchScreenState extends State<ClientesSearchScreen> {
  List<Clientes> _results = [];
  List<Clientes> _filteredResults = [];
  DatabaseProvider _databaseProvider = DatabaseProvider();
  late ClientesRepository _clientesRepository;
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    initDatabase();
    _searchController.addListener(_filterResults);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void initDatabase() async {
    await _databaseProvider.open();
    _clientesRepository = ClientesRepository(_databaseProvider);
    List<Clientes> res = await _clientesRepository.findAll();
    setState(() {
      _results = res;
      _filteredResults = res;
    });
  }

  void _filterResults() {
    setState(() {
      if (_searchController.text.isEmpty) {
        _filteredResults = _results;
      } else {
        _filteredResults = _results.where((cliente) {
          return cliente.nome
                  ?.toLowerCase()
                  .contains(_searchController.text.toLowerCase()) ??
              false;
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Clientes"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _createSearchTextField(context),
            const SizedBox(height: 16),
            _createListView(context),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue[400],
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () async {
          await Navigator.pushNamed(context, ClientesFormScreen.routeName);
          _buscarTodos();
        },
      ),
    );
  }

  Widget _createSearchTextField(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              labelText: "Pesquisar...",
              suffixIcon: Icon(Icons.search),
            ),
          ),
        ),
      ],
    );
  }

  Widget _createListView(BuildContext context) {
    if (_filteredResults.isEmpty) {
      return const Text(
        "Sem dados disponíveis",
        style: TextStyle(fontSize: 20),
      );
    } else {
      return Expanded(
        child: ListView.builder(
          itemCount: _filteredResults.length,
          itemBuilder: (context, index) => _createItem(context, index),
        ),
      );
    }
  }

  Widget _createItem(BuildContext context, int index) {
    Clientes cliente = _filteredResults[index];
    return Card(
      child: ListTile(
        title: Text(cliente.nome ?? ''),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.directions_car),
              onPressed: () async {
                // Código para editar o cliente
                await Navigator.of(context).pushNamed(
                  VeiculosFormScreen.routeName,
                );
                _buscarTodos();
              },
            ),
            IconButton(
              icon: const Icon(Icons.location_on),
              onPressed: () async {
                // Código para editar o cliente
                await Navigator.of(context).pushNamed(
                  EnderecoFormScreen.routeName,
                );
                _buscarTodos();
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () async {
                await _clientesRepository.delete(cliente);
                _buscarTodos();
              },
            ),
          ],
        ),
        onTap: () async {
          await Navigator.of(context)
              .pushNamed(ClientesFormScreen.routeName, arguments: cliente);
          _buscarTodos();
        },
      ),
    );
  }

  Future<void> _buscarTodos() async {
    List<Clientes> res = await _clientesRepository.findAll();
    setState(() {
      _results = res;
      _filteredResults = res;
    });
  }
}
