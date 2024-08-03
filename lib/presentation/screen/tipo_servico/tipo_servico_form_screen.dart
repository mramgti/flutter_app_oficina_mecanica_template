import 'package:flutter/material.dart';
import 'package:flutter_app_oficina_mecanica_template/data/database_provider.dart';
import 'package:flutter_app_oficina_mecanica_template/domain/models/tipo_peca_servico_model.dart';
import 'package:flutter_app_oficina_mecanica_template/domain/repositories/repository_sqlite.dart';
import 'package:flutter_app_oficina_mecanica_template/presentation/widgets/helper_widgets.dart';

class TipoPecaServicoFormScreen extends StatefulWidget {
  static const String routeName = "tipoPecaServicoForm";

  const TipoPecaServicoFormScreen({Key? key}) : super(key: key);

  @override
  _TipoPecaServicoFormScreenState createState() =>
      _TipoPecaServicoFormScreenState();
}

class _TipoPecaServicoFormScreenState extends State<TipoPecaServicoFormScreen> {
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();

  TextEditingController _nomeController = TextEditingController();

  TipoPecaServico _tipoPecaServico = TipoPecaServico();

  DatabaseProvider _databaseProvider = DatabaseProvider();
  late RepositorySQLite _tipoPecaServicoRepository;

  void initDatabase() async {
    _tipoPecaServicoRepository = RepositorySQLite(_databaseProvider);
  }

  @override
  void initState() {
    super.initState();
    initDatabase();
  }

  void save() async {
    _tipoPecaServico.nome = _nomeController.text;

    if (_tipoPecaServico.idTipoPecaServico == null) {
      await _tipoPecaServicoRepository.insert(_tipoPecaServico);
    } else {
      await _tipoPecaServicoRepository.update(_tipoPecaServico);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context)!.settings.arguments != null) {
      TipoPecaServico tipoPecaServico = ModalRoute.of(context)!.settings.arguments as TipoPecaServico;
      _tipoPecaServico.idTipoPecaServico = tipoPecaServico.idTipoPecaServico;
      _nomeController.text = tipoPecaServico.nome!;
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
        title: const Text('Cadastro de Tipos de Peça/Serviço'),
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
