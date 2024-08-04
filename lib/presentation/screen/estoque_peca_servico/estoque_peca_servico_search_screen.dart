import 'package:flutter/material.dart';
import 'package:flutter_app_oficina_mecanica_template/data/database_provider.dart';
import 'package:flutter_app_oficina_mecanica_template/domain/models/entity.dart';
import 'package:flutter_app_oficina_mecanica_template/domain/models/estoque_peca_servico_model.dart';
import 'package:flutter_app_oficina_mecanica_template/domain/repositories/repository_sqlite.dart';
import 'package:flutter_app_oficina_mecanica_template/presentation/screen/estoque_peca_servico/estoque_peca_servico_form_screen.dart';

class EstoquePecaServicoSearchScreen extends StatefulWidget {
  static const String routeName = "estoquePecaServico";

  const EstoquePecaServicoSearchScreen({Key? key}) : super(key: key);

  @override
  _EstoquePecaServicoSearchScreenState createState() =>
      _EstoquePecaServicoSearchScreenState();
}

class _EstoquePecaServicoSearchScreenState
    extends State<EstoquePecaServicoSearchScreen> {
  List<EstoquePecaServico> _results = [];
  List<EstoquePecaServico> _filteredResults = [];
  DatabaseProvider _databaseProvider = DatabaseProvider();
  late RepositorySQLite _repository;
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
    _repository = RepositorySQLite(_databaseProvider);
    List<Entity> res = await _repository.findAll(EstoquePecaServico());
    List<EstoquePecaServico> list = res.whereType<EstoquePecaServico>().toList();

    setState(() {
      _results = list;
      _filteredResults = list;
    });
  }

  void _filterResults() {
    setState(() {
      if (_searchController.text.isEmpty) {
        _filteredResults = _results;
      } else {
        _filteredResults = _results.where((item) {
          return item.nome?.toLowerCase().contains(_searchController.text.toLowerCase()) ?? false ||
                 item.precoCompra.toString().contains(_searchController.text) ||
                 item.precoVenda.toString().contains(_searchController.text) ||
                 item.quantidade.toString().contains(_searchController.text);
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Estoque de Peças e Serviços"),
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
          await Navigator.pushNamed(context, EstoquePecaServicoFormScreen.routeName);
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
    EstoquePecaServico item = _filteredResults[index];
    return Card(
      child: ListTile(
        title: Text(item.nome ?? 'Sem nome'),
        subtitle: Text("Preço de Compra: ${item.precoCompra}, Preço de Venda: ${item.precoVenda}, Quantidade: ${item.quantidade}"),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () async {
                await Navigator.of(context).pushNamed(
                    EstoquePecaServicoFormScreen.routeName,
                    arguments: item);
                _fetchAll();
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () async {
                _showDeleteConfirmationDialog(context, item);
              },
            ),
          ],
        ),
        onTap: () async {
          await Navigator.of(context).pushNamed(
              EstoquePecaServicoFormScreen.routeName,
              arguments: item);
          _fetchAll();
        },
      ),
    );
  }

  Future<void> _fetchAll() async {
    List<Entity> res = await _repository.findAll(EstoquePecaServico());
    List<EstoquePecaServico> list = res.whereType<EstoquePecaServico>().toList();
    setState(() {
      _results = list;
      _filteredResults = list;
    });
  }

  void _showDeleteConfirmationDialog(BuildContext context, EstoquePecaServico item) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Confirmar Exclusão"),
          content: const Text("Tem certeza de que deseja excluir este registro?"),
          actions: [
            TextButton(
              onPressed: () async {
                await _repository.delete(item);
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
