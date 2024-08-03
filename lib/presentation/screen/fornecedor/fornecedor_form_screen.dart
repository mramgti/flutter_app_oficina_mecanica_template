import 'package:flutter/material.dart';
import 'package:flutter_app_oficina_mecanica_template/data/database_provider.dart';
import 'package:flutter_app_oficina_mecanica_template/domain/models/fornecedor_model.dart';
import 'package:flutter_app_oficina_mecanica_template/domain/repositories/repository_sqlite.dart';
import 'package:flutter_app_oficina_mecanica_template/presentation/widgets/helper_widgets.dart';

class FornecedorFormScreen extends StatefulWidget {
  static const String routeName = "fornecedoresForm";

  const FornecedorFormScreen({Key? key}) : super(key: key);

  @override
  _FornecedoresFormScreenState createState() => _FornecedoresFormScreenState();
}

class _FornecedoresFormScreenState extends State<FornecedorFormScreen> {
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();

  TextEditingController _cnpjController = TextEditingController();
  TextEditingController _nomeController = TextEditingController();

  Fornecedor _fornecedor = Fornecedor();

  DatabaseProvider _databaseProvider = DatabaseProvider();
  late RepositorySQLite _fornecedoresRepository;

  void initDatabase() async {
    _fornecedoresRepository = RepositorySQLite(_databaseProvider);
  }

  @override
  void initState() {
    super.initState();
    initDatabase();
  }

  void save() async {
    _fornecedor.cnpj = _cnpjController.text;
    _fornecedor.nome = _nomeController.text;

    if (_fornecedor.idFornecedor == null) {
      await _fornecedoresRepository.insert(_fornecedor);
    } else {
      await _fornecedoresRepository.update(_fornecedor);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context)!.settings.arguments != null) {
      Fornecedor fornecedor =
          ModalRoute.of(context)!.settings.arguments as Fornecedor;
      _fornecedor.idFornecedor = fornecedor.idFornecedor;
      _cnpjController.text = fornecedor.cnpj ?? '';
      _nomeController.text = fornecedor.nome ?? '';
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
        title: const Text('Cadastro de Fornecedores'),
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
                    "CNPJ", "Campo Obrigatório!", _cnpjController),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                HelperWidgets.createTextForm(
                    "Nome", "Campo Obrigatório!", _nomeController),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
