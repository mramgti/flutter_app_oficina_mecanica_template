import 'package:flutter/material.dart';
import 'package:flutter_app_oficina_mecanica_template/data/database_provider.dart';
import 'package:flutter_app_oficina_mecanica_template/domain/models/fornecedor_model.dart';
import 'package:flutter_app_oficina_mecanica_template/domain/models/entity.dart';
import 'package:flutter_app_oficina_mecanica_template/domain/repositories/repository_sqlite.dart';
import 'package:flutter_app_oficina_mecanica_template/presentation/screen/fornecedor/fornecedor_form_screen.dart';

class FornecedorSearchScreen extends StatefulWidget {
  static const String routeName = "fornecedores";

  const FornecedorSearchScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FornecedoresSearchScreenState();
}

class _FornecedoresSearchScreenState extends State<FornecedorSearchScreen> {
  List<Fornecedor> _results = [];
  List<Fornecedor> _filteredResults = [];
  DatabaseProvider _databaseProvider = DatabaseProvider();
  late RepositorySQLite _fornecedoresRepository;
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
    _fornecedoresRepository = RepositorySQLite(_databaseProvider);
    List<Entity> res = await _fornecedoresRepository.findAll(Fornecedor());
    List<Fornecedor> fornecedoresList = res.whereType<Fornecedor>().toList();

    setState(() {
      _results = fornecedoresList;
      _filteredResults = fornecedoresList;
    });
  }

  void _filterResults() {
    setState(() {
      if (_searchController.text.isEmpty) {
        _filteredResults = _results;
      } else {
        _filteredResults = _results.where((fornecedor) {
          return fornecedor.nome
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
        title: Text("Fornecedores"),
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
          await Navigator.pushNamed(context, FornecedorFormScreen.routeName);
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
    Fornecedor fornecedor = _filteredResults[index];
    return Card(
      child: ListTile(
        title: Text(fornecedor.nome ?? ''),
        subtitle: Text(fornecedor.cnpj ?? ''),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () async {
            await _fornecedoresRepository.delete(fornecedor);
            _buscarTodos();
          },
        ),
        onTap: () async {
          await Navigator.of(context)
              .pushNamed(FornecedorFormScreen.routeName, arguments: fornecedor);
          _buscarTodos();
        },
      ),
    );
  }

  Future<void> _buscarTodos() async {
    List<Entity> res = await _fornecedoresRepository.findAll(Fornecedor());
    List<Fornecedor> fornecedoresList = res.whereType<Fornecedor>().toList();
    setState(() {
      _results = fornecedoresList;
      _filteredResults = fornecedoresList;
    });
  }
}
