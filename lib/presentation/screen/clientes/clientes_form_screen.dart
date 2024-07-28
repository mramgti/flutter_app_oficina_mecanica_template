import 'package:flutter/material.dart';
import 'package:flutter_app_oficina_mecanica_template/data/database_provider.dart';
import 'package:flutter_app_oficina_mecanica_template/domain/models/clientes_model.dart';
import 'package:flutter_app_oficina_mecanica_template/domain/repositories/clientes_repository.dart';
import 'package:flutter_app_oficina_mecanica_template/presentation/widgets/helper_widgets.dart';

class ClientesFormScreen extends StatefulWidget {
  static const String routeName = "clientesForm";

  const ClientesFormScreen({Key? key}) : super(key: key);

  @override
  _ClientesFormScreenState createState() => _ClientesFormScreenState();
}

class _ClientesFormScreenState extends State<ClientesFormScreen> {
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();

  TextEditingController _cpfController = TextEditingController();
  TextEditingController _nomeController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _dataNascimentoController = TextEditingController();
  TextEditingController _dataCadastroController = TextEditingController();
  TextEditingController _codOrdemServicoController = TextEditingController();

  Clientes _cliente = Clientes();

  DatabaseProvider _databaseProvider = DatabaseProvider();
  late ClientesRepository _clientesRepository;

  void initDatabase() async {
    _clientesRepository = ClientesRepository(_databaseProvider);
  }

  @override
  void initState() {
    super.initState();
    initDatabase();
  }

  void save() async {
    _cliente.cpf = _cpfController.text;
    _cliente.nome = _nomeController.text;
    _cliente.email = _emailController.text;
    _cliente.dataNascimento = _dataNascimentoController.text;
    _cliente.dataCadastro = _dataCadastroController.text;
    _cliente.codOrdemServico = int.tryParse(_codOrdemServicoController.text);

    if (_cliente.id == null) {
      await _clientesRepository.insert(_cliente);
    } else {
      await _clientesRepository.update(_cliente);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context)!.settings.arguments != null) {
      Clientes cliente = ModalRoute.of(context)!.settings.arguments as Clientes;
      _cliente.id = cliente.id;
      _cpfController.text = cliente.cpf!;
      _nomeController.text = cliente.nome!;
      _emailController.text = cliente.email!;
      _dataNascimentoController.text = cliente.dataNascimento!;
      _dataCadastroController.text = cliente.dataCadastro!;
      _codOrdemServicoController.text = cliente.codOrdemServico!.toString();
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
            icon: const Icon(Icons.check),
          ),
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.cancel),
          ),
        ],
        title: const Text('Cadastro de Clientes'),
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
                HelperWidgets.createTextForm("CPF", "Campo Obrigatório!", _cpfController),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                HelperWidgets.createTextForm("Nome", "Campo Obrigatório!", _nomeController),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                HelperWidgets.createTextForm("Email", "Campo Obrigatório!", _emailController),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                HelperWidgets.createTextForm("Data de Nascimento", "Campo Obrigatório!", _dataNascimentoController),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                HelperWidgets.createTextForm("Data de Cadastro", "Campo Obrigatório!", _dataCadastroController),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                HelperWidgets.createTextForm("Código Ordem de Serviço", "Campo Obrigatório!", _codOrdemServicoController),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
