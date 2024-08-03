import 'package:flutter/material.dart';
import 'package:flutter_app_oficina_mecanica_template/data/database_provider.dart';
import 'package:flutter_app_oficina_mecanica_template/domain/models/tipo_pagamento_model.dart';
import 'package:flutter_app_oficina_mecanica_template/domain/models/entity.dart';
import 'package:flutter_app_oficina_mecanica_template/domain/repositories/repository_sqlite.dart';
import 'package:flutter_app_oficina_mecanica_template/presentation/screen/tipo_pagamento/tipo_pagamento_form_screen.dart';

class TipoPagamentoSearchScreen extends StatefulWidget {
  static const String routeName = "tipoPagamento";

  const TipoPagamentoSearchScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TipoPagamentoSearchScreenState();
}

class _TipoPagamentoSearchScreenState extends State<TipoPagamentoSearchScreen> {
  List<TipoPagamento> _results = [];
  List<TipoPagamento> _filteredResults = [];
  DatabaseProvider _databaseProvider = DatabaseProvider();
  late RepositorySQLite _tipoPagamentoRepository;
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
    _tipoPagamentoRepository = RepositorySQLite(_databaseProvider);
    List<Entity> res = await _tipoPagamentoRepository.findAll(TipoPagamento());
    List<TipoPagamento> tipoPagamentoList = res.whereType<TipoPagamento>().toList();

    setState(() {
      _results = tipoPagamentoList;
      _filteredResults = tipoPagamentoList;
    });
  }

  void _filterResults() {
    setState(() {
      if (_searchController.text.isEmpty) {
        _filteredResults = _results;
      } else {
        _filteredResults = _results.where((tipoPagamento) {
          return tipoPagamento.nome?.toLowerCase().contains(_searchController.text.toLowerCase()) ?? false;
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tipos de Pagamento"),
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
          await Navigator.pushNamed(context, TipoPagamentoFormScreen.routeName);
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
    TipoPagamento tipoPagamento = _filteredResults[index];
    return Card(
      child: ListTile(
        title: Text(tipoPagamento.nome ?? ''),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () async {
                await Navigator.of(context).pushNamed(
                    TipoPagamentoFormScreen.routeName,
                    arguments: tipoPagamento);
                _fetchAll();
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () async {
                _showDeleteConfirmationDialog(context, tipoPagamento);
              },
            ),
          ],
        ),
        onTap: () async {
          await Navigator.of(context).pushNamed(
              TipoPagamentoFormScreen.routeName,
              arguments: tipoPagamento);
          _fetchAll();
        },
      ),
    );
  }

  Future<void> _fetchAll() async {
    List<Entity> res = await _tipoPagamentoRepository.findAll(TipoPagamento());
    List<TipoPagamento> tipoPagamentoList = res.whereType<TipoPagamento>().toList();
    setState(() {
      _results = tipoPagamentoList;
      _filteredResults = tipoPagamentoList;
    });
  }

  void _showDeleteConfirmationDialog(BuildContext context, TipoPagamento tipoPagamento) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Confirmar Exclusão"),
          content: const Text("Tem certeza de que deseja excluir este tipo de pagamento?"),
          actions: [
            TextButton(
              onPressed: () async {
                await _tipoPagamentoRepository.delete(tipoPagamento);
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
