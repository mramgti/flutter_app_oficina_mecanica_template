import 'package:flutter/material.dart';
import 'package:flutter_app_oficina_mecanica_template/data/database_provider.dart';
import 'package:flutter_app_oficina_mecanica_template/domain/models/tipo_status_model.dart';
import 'package:flutter_app_oficina_mecanica_template/domain/repositories/repository_sqlite.dart';
import 'package:flutter_app_oficina_mecanica_template/presentation/widgets/helper_widgets.dart';

class TipoStatusFormScreen extends StatefulWidget {
  static const String routeName = "tipoStatusForm";

  const TipoStatusFormScreen({Key? key}) : super(key: key);

  @override
  _TipoStatusFormScreenState createState() => _TipoStatusFormScreenState();
}

class _TipoStatusFormScreenState extends State<TipoStatusFormScreen> {
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();

  TextEditingController _nomeController = TextEditingController();

  TipoStatus _tipoStatus = TipoStatus();

  DatabaseProvider _databaseProvider = DatabaseProvider();
  late RepositorySQLite _tipoStatusRepository;

  void initDatabase() async {
    _tipoStatusRepository = RepositorySQLite(_databaseProvider);
  }

  @override
  void initState() {
    super.initState();
    initDatabase();
  }

  void save() async {
    _tipoStatus.nome = _nomeController.text;

    if (_tipoStatus.idTipoStatus == null) {
      await _tipoStatusRepository.insert(_tipoStatus);
    } else {
      await _tipoStatusRepository.update(_tipoStatus);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context)!.settings.arguments != null) {
      TipoStatus tipoStatus = ModalRoute.of(context)!.settings.arguments as TipoStatus;
      _tipoStatus.idTipoStatus = tipoStatus.idTipoStatus;
      _nomeController.text = tipoStatus.nome!;
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
        title: const Text('Cadastro de Tipos de Status'),
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
