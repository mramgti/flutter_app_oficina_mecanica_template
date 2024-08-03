import 'package:flutter/material.dart';
import 'package:flutter_app_oficina_mecanica_template/data/database_provider.dart';
import 'package:flutter_app_oficina_mecanica_template/domain/models/tipo_pagamento_model.dart';
import 'package:flutter_app_oficina_mecanica_template/domain/repositories/repository_sqlite.dart';
import 'package:flutter_app_oficina_mecanica_template/presentation/widgets/helper_widgets.dart';

class TipoPagamentoFormScreen extends StatefulWidget {
  static const String routeName = "tipoPagamentoForm";

  const TipoPagamentoFormScreen({Key? key}) : super(key: key);

  @override
  _TipoPagamentoFormScreenState createState() =>
      _TipoPagamentoFormScreenState();
}

class _TipoPagamentoFormScreenState extends State<TipoPagamentoFormScreen> {
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();

  TextEditingController _nomeController = TextEditingController();

  TipoPagamento _tipoPagamento = TipoPagamento();

  DatabaseProvider _databaseProvider = DatabaseProvider();
  late RepositorySQLite _tipoPagamentoRepository;

  void initDatabase() async {
    _tipoPagamentoRepository = RepositorySQLite(_databaseProvider);
  }

  @override
  void initState() {
    super.initState();
    initDatabase();
  }

  void save() async {
    _tipoPagamento.nome = _nomeController.text;

    if (_tipoPagamento.idTipoPagamento == null) {
      await _tipoPagamentoRepository.insert(_tipoPagamento);
    } else {
      await _tipoPagamentoRepository.update(_tipoPagamento);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context)!.settings.arguments != null) {
      TipoPagamento tipoPagamento = ModalRoute.of(context)!.settings.arguments as TipoPagamento;
      _tipoPagamento.idTipoPagamento = tipoPagamento.idTipoPagamento;
      _nomeController.text = tipoPagamento.nome!;
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              if (!_formState.currentState!.validate()) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Aviso!"),
                      content: const Text("Preencha os campos obrigatórios!"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("OK"),
                        ),
                      ],
                    );
                  },
                );
              } else {
                save();
                Navigator.pop(context);
              }
            },
            icon: const Icon(Icons.check, color: Colors.blue),
          ),
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.cancel, color: Colors.red),
          ),
        ],
        title: const Text('Cadastro de Tipos de Pagamento'),
      ),
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formState,
        child: Column(
          children: [
            Row(
              children: [
                HelperWidgets.createTextForm(
                    "Nome", "Campo Obrigatório!", _nomeController),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
