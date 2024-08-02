import 'package:flutter/material.dart';
import 'package:flutter_app_oficina_mecanica_template/data/database_provider.dart';
import 'package:flutter_app_oficina_mecanica_template/domain/models/endereco_model.dart';
import 'package:flutter_app_oficina_mecanica_template/domain/repositories/repository_sqlite.dart';
import 'package:flutter_app_oficina_mecanica_template/presentation/widgets/helper_widgets.dart';

class EnderecoArguments {
  final int idCliente;
  final Endereco? endereco;

  EnderecoArguments({required this.idCliente, this.endereco});
}

class EnderecoFormScreen extends StatefulWidget {
  static const String routeName = "enderecoForm";

  const EnderecoFormScreen({Key? key}) : super(key: key);

  @override
  _EnderecoFormScreenState createState() => _EnderecoFormScreenState();
}

class _EnderecoFormScreenState extends State<EnderecoFormScreen> {
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();

  TextEditingController _ruaController = TextEditingController();
  TextEditingController _numeroController = TextEditingController();
  TextEditingController _complementoController = TextEditingController();
  TextEditingController _bairroController = TextEditingController();
  TextEditingController _cidadeController = TextEditingController();
  TextEditingController _estadoController = TextEditingController();
  TextEditingController _cepController = TextEditingController();
  TextEditingController _pontoReferenciaController = TextEditingController();
  TextEditingController _telefoneController = TextEditingController();

  Endereco _endereco = Endereco();

  DatabaseProvider _databaseProvider = DatabaseProvider();
  late RepositorySQLite _enderecoRepository;

  int? _idCliente;

  void initDatabase() async {
    _enderecoRepository = RepositorySQLite(_databaseProvider);
  }

  @override
  void initState() {
    super.initState();
    initDatabase();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arguments = ModalRoute.of(context)?.settings.arguments as EnderecoArguments?;
    if (arguments != null) {
      _idCliente = arguments.idCliente;
      final endereco = arguments.endereco;
      if (endereco != null) {
        _endereco = endereco;
        _ruaController.text = endereco.rua ?? '';
        _numeroController.text = endereco.numero ?? '';
        _complementoController.text = endereco.complemento ?? '';
        _bairroController.text = endereco.bairro ?? '';
        _cidadeController.text = endereco.cidade ?? '';
        _estadoController.text = endereco.estado ?? '';
        _cepController.text = endereco.cep ?? '';
        _pontoReferenciaController.text = endereco.pontoReferencia ?? '';
        _telefoneController.text = endereco.telefone ?? '';
      }
    }
  }

  void save() async {
    _endereco.rua = _ruaController.text;
    _endereco.numero = _numeroController.text;
    _endereco.complemento = _complementoController.text;
    _endereco.bairro = _bairroController.text;
    _endereco.cidade = _cidadeController.text;
    _endereco.estado = _estadoController.text;
    _endereco.cep = _cepController.text;
    _endereco.pontoReferencia = _pontoReferenciaController.text;
    _endereco.telefone = _telefoneController.text;

    if (_idCliente != null) {
      _endereco.idCliente = _idCliente; // Associando o endereço ao cliente
    }

    if (_endereco.idEndereco == null) {
      await _enderecoRepository.insert(_endereco);
    } else {
      await _enderecoRepository.update(_endereco);
    }
  }

  @override
  Widget build(BuildContext context) {
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
            icon: const Icon(
              Icons.check,
              color: Colors.blue,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.cancel,
              color: Colors.red,
            ),
          ),
        ],
        title: const Text('Cadastro de Endereços'),
      ),
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formState,
          child: Column(
            children: [
              Row(
                children: [
                  HelperWidgets.createTextForm(
                      "Rua", "Campo Obrigatório!", _ruaController),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  HelperWidgets.createTextForm(
                      "Número", "Campo Obrigatório!", _numeroController),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  HelperWidgets.createTextForm(
                      "Complemento", "Campo Opcional", _complementoController),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  HelperWidgets.createTextForm(
                      "Bairro", "Campo Obrigatório!", _bairroController),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  HelperWidgets.createTextForm(
                      "Cidade", "Campo Obrigatório!", _cidadeController),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  HelperWidgets.createTextForm(
                      "Estado", "Campo Obrigatório!", _estadoController),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  HelperWidgets.createTextForm(
                      "CEP", "Campo Obrigatório!", _cepController),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  HelperWidgets.createTextForm("Ponto de Referência",
                      "Campo Opcional", _pontoReferenciaController),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  HelperWidgets.createTextForm(
                      "Telefone", "Campo Opcional", _telefoneController),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
