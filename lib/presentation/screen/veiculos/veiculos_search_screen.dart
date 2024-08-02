import 'package:flutter/material.dart';
import 'package:flutter_app_oficina_mecanica_template/data/database_provider.dart';
import 'package:flutter_app_oficina_mecanica_template/domain/models/entity.dart';
import 'package:flutter_app_oficina_mecanica_template/domain/models/veiculos_model.dart';
import 'package:flutter_app_oficina_mecanica_template/domain/repositories/repository_sqlite.dart';
import 'package:flutter_app_oficina_mecanica_template/presentation/screen/veiculos/veiculos_form_screen.dart';

class VeiculosSearchScreen extends StatefulWidget {
  static const String routeName = "veiculos";

  const VeiculosSearchScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _VeiculosSearchScreenState();
}

class _VeiculosSearchScreenState extends State<VeiculosSearchScreen> {
  List<Veiculos> _results = [];
  List<Veiculos> _filteredResults = [];
  DatabaseProvider _databaseProvider = DatabaseProvider();
  late RepositorySQLite _veiculosRepository;
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
    _veiculosRepository = RepositorySQLite(_databaseProvider);
    List<Entity> res = await _veiculosRepository.findAll(Veiculos());
    List<Veiculos> veiculosList = res.whereType<Veiculos>().toList();
    setState(() {
      _results = veiculosList;
      _filteredResults = veiculosList;
    });
  }

  void _filterResults() {
    setState(() {
      if (_searchController.text.isEmpty) {
        _filteredResults = _results;
      } else {
        _filteredResults = _results.where((veiculo) {
          return veiculo.placa?.toLowerCase().contains(_searchController.text.toLowerCase()) ?? false;
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Veículos"),
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
          await Navigator.pushNamed(context, VeiculosFormScreen.routeName);
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
            decoration: const InputDecoration(
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
    Veiculos veiculo = _filteredResults[index];
    return Card(
      child: ListTile(
        title: Text(veiculo.placa ?? ''),
        subtitle: Text('${veiculo.modelo ?? ''}, ${veiculo.marca ?? ''}'),
        leading: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () async {
            await _veiculosRepository.delete(veiculo);
            _buscarTodos();
          },
        ),
        onTap: () async {
          await Navigator.of(context).pushNamed(VeiculosFormScreen.routeName, arguments: veiculo);
          _buscarTodos();
        },
      ),
    );
  }

  Future<void> _buscarTodos() async {
    List<Entity> res = await _veiculosRepository.findAll(Veiculos());
    List<Veiculos> veiculosList = res.whereType<Veiculos>().toList();
    setState(() {
      _results = veiculosList;
      _filteredResults = veiculosList;
    });
  }
}
