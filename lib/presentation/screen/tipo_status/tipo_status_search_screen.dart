import 'package:flutter/material.dart';
import 'package:flutter_app_oficina_mecanica_template/data/database_provider.dart';
import 'package:flutter_app_oficina_mecanica_template/domain/models/tipo_status_model.dart';
import 'package:flutter_app_oficina_mecanica_template/domain/models/entity.dart';
import 'package:flutter_app_oficina_mecanica_template/domain/repositories/repository_sqlite.dart';
import 'package:flutter_app_oficina_mecanica_template/presentation/screen/tipo_status/tipo_status_form_screen.dart';

class TipoStatusSearchScreen extends StatefulWidget {
  static const String routeName = "tipoStatus";

  const TipoStatusSearchScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TipoStatusSearchScreenState();
}

class _TipoStatusSearchScreenState extends State<TipoStatusSearchScreen> {
  List<TipoStatus> _results = [];
  List<TipoStatus> _filteredResults = [];
  DatabaseProvider _databaseProvider = DatabaseProvider();
  late RepositorySQLite _tipoStatusRepository;
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
    _tipoStatusRepository = RepositorySQLite(_databaseProvider);
    List<Entity> res = await _tipoStatusRepository.findAll(TipoStatus());
    List<TipoStatus> tipoStatusList = res.whereType<TipoStatus>().toList();

    setState(() {
      _results = tipoStatusList;
      _filteredResults = tipoStatusList;
    });
  }

  void _filterResults() {
    setState(() {
      if (_searchController.text.isEmpty) {
        _filteredResults = _results;
      } else {
        _filteredResults = _results.where((tipoStatus) {
          return tipoStatus.nome?.toLowerCase().contains(_searchController.text.toLowerCase()) ?? false;
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tipos de Status"),
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
          await Navigator.pushNamed(context, TipoStatusFormScreen.routeName);
          _fetchAll();
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
    TipoStatus tipoStatus = _filteredResults[index];
    return Card(
      child: ListTile(
        title: Text(tipoStatus.nome ?? ''),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () async {
                await Navigator.of(context).pushNamed(
                    TipoStatusFormScreen.routeName,
                    arguments: tipoStatus);
                _fetchAll();
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () async {
                _showDeleteConfirmationDialog(context, tipoStatus);
              },
            ),
          ],
        ),
        onTap: () async {
          await Navigator.of(context).pushNamed(
              TipoStatusFormScreen.routeName,
              arguments: tipoStatus);
          _fetchAll();
        },
      ),
    );
  }

  Future<void> _fetchAll() async {
    List<Entity> res = await _tipoStatusRepository.findAll(TipoStatus());
    List<TipoStatus> tipoStatusList = res.whereType<TipoStatus>().toList();
    setState(() {
      _results = tipoStatusList;
      _filteredResults = tipoStatusList;
    });
  }

  void _showDeleteConfirmationDialog(BuildContext context, TipoStatus tipoStatus) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Confirmar Exclusão"),
          content: const Text("Tem certeza de que deseja excluir este tipo de status?"),
          actions: [
            TextButton(
              onPressed: () async {
                await _tipoStatusRepository.delete(tipoStatus);
                Navigator.of(context).pop(); // Fecha o diálogo
                _fetchAll(); // Atualiza a lista
              },
              child: const Text("Excluir"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o diálogo sem excluir
              },
              child: const Text("Cancelar"),
            ),
          ],
        );
      },
    );
  }
}
