import 'package:flutter/material.dart';
import 'package:flutter_app_oficina_mecanica_template/data/database_provider.dart';
import 'package:flutter_app_oficina_mecanica_template/domain/models/endereco_model.dart';
import 'package:flutter_app_oficina_mecanica_template/domain/repositories/endereco_repository.dart';
import 'package:flutter_app_oficina_mecanica_template/presentation/screen/clientes/endereco_form_screen.dart';

class EnderecoSearchScreen extends StatefulWidget {
  static const String routeName = "endereco";

  const EnderecoSearchScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EnderecoSearchScreenState();
}

class _EnderecoSearchScreenState extends State<EnderecoSearchScreen> {
  List<Endereco> _results = [];
  List<Endereco> _filteredResults = [];
  DatabaseProvider _databaseProvider = DatabaseProvider();
  late EnderecoRepository _enderecoRepository;
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
    _enderecoRepository = EnderecoRepository(_databaseProvider);
    List<Endereco> res = await _enderecoRepository.findAll();
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
        _filteredResults = _results.where((endereco) {
          return endereco.rua?.toLowerCase().contains(_searchController.text.toLowerCase()) ?? false;
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Endereços"),
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
          await Navigator.pushNamed(context, EnderecoFormScreen.routeName);
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
    Endereco endereco = _filteredResults[index];
    return Card(
      child: ListTile(
        title: Text(endereco.rua ?? ''),
        subtitle: Text('${endereco.bairro ?? ''}, ${endereco.cidade ?? ''}'),
        leading: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () async {
            await _enderecoRepository.delete(endereco);
            _buscarTodos();
          },
        ),
        onTap: () async {
          await Navigator.of(context).pushNamed(EnderecoFormScreen.routeName, arguments: endereco);
          _buscarTodos();
        },
      ),
    );
  }

  Future<void> _buscarTodos() async {
    List<Endereco> res = await _enderecoRepository.findAll();
    setState(() {
      _results = res;
      _filteredResults = res;
    });
  }
}
