import 'package:flutter/material.dart';
import 'package:flutter_app_oficina_mecanica_template/data/database_provider.dart';
import 'package:flutter_app_oficina_mecanica_template/domain/models/tipo_funcionario_model.dart'; // Certifique-se de que este caminho esteja correto
import 'package:flutter_app_oficina_mecanica_template/domain/repositories/repository_sqlite.dart';
import 'package:flutter_app_oficina_mecanica_template/presentation/widgets/helper_widgets.dart';

class TipoFuncionarioFormScreen extends StatefulWidget {
  static const String routeName = "tipoFuncionarioForm";

  const TipoFuncionarioFormScreen({Key? key}) : super(key: key);

  @override
  _TipoFuncionarioFormScreenState createState() =>
      _TipoFuncionarioFormScreenState();
}

class _TipoFuncionarioFormScreenState extends State<TipoFuncionarioFormScreen> {
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();

  TextEditingController _nomeController = TextEditingController();

  TipoFuncionario _tipoFuncionario = TipoFuncionario();

  DatabaseProvider _databaseProvider = DatabaseProvider();
  late RepositorySQLite _tipoFuncionarioRepository;

  void initDatabase() async {
    _tipoFuncionarioRepository = RepositorySQLite(_databaseProvider);
  }

  @override
  void initState() {
    super.initState();
    initDatabase();
  }

  void save() async {
    _tipoFuncionario.nome = _nomeController.text;

    if (_tipoFuncionario.idTipoFuncionario == null) {
      await _tipoFuncionarioRepository.insert(_tipoFuncionario);
    } else {
      await _tipoFuncionarioRepository.update(_tipoFuncionario);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context)!.settings.arguments != null) {
      TipoFuncionario tipoFuncionario =
          ModalRoute.of(context)!.settings.arguments as TipoFuncionario;
      _tipoFuncionario.idTipoFuncionario = tipoFuncionario.idTipoFuncionario;
      _nomeController.text = tipoFuncionario.nome!;
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
        title: const Text('Cadastro de Cargos'),
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
