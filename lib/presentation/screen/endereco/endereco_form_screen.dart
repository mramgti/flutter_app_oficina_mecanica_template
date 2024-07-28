import 'package:flutter/material.dart';
import 'package:flutter_app_oficina_mecanica_template/data/database_provider.dart';
import 'package:flutter_app_oficina_mecanica_template/domain/models/endereco_model.dart';
import 'package:flutter_app_oficina_mecanica_template/domain/repositories/endereco_repository.dart';
import 'package:flutter_app_oficina_mecanica_template/presentation/widgets/helper_widgets.dart';

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
  TextEditingController _cpfController = TextEditingController();
  TextEditingController _cnpjController = TextEditingController();

  Endereco _endereco = Endereco();

  DatabaseProvider _databaseProvider = DatabaseProvider();
  late EnderecoRepository _enderecoRepository;

  void initDatabase() async {
    _enderecoRepository = EnderecoRepository(_databaseProvider);
  }

  @override
  void initState() {
    super.initState();
    initDatabase();
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
    _endereco.cpf = _cpfController.text;
    _endereco.cnpj = _cnpjController.text;

    if (_endereco.id == null) {
      await _enderecoRepository.insert(_endereco);
    } else {
      await _enderecoRepository.update(_endereco);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context)!.settings.arguments != null) {
      Endereco endereco = ModalRoute.of(context)!.settings.arguments as Endereco;
      _endereco.id = endereco.id;
      _ruaController.text = endereco.rua ?? '';
      _numeroController.text = endereco.numero ?? '';
      _complementoController.text = endereco.complemento ?? '';
      _bairroController.text = endereco.bairro ?? '';
      _cidadeController.text = endereco.cidade ?? '';
      _estadoController.text = endereco.estado ?? '';
      _cepController.text = endereco.cep ?? '';
      _pontoReferenciaController.text = endereco.pontoReferencia ?? '';
      _telefoneController.text = endereco.telefone ?? '';
      _cpfController.text = endereco.cpf ?? '';
      _cnpjController.text = endereco.cnpj ?? '';
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
        title: const Text('Cadastro de Endereços'),
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
                HelperWidgets.createTextForm("Rua", "Campo Obrigatório!", _ruaController),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                HelperWidgets.createTextForm("Número", "Campo Obrigatório!", _numeroController),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                HelperWidgets.createTextForm("Complemento", "Campo Opcional", _complementoController),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                HelperWidgets.createTextForm("Bairro", "Campo Obrigatório!", _bairroController),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                HelperWidgets.createTextForm("Cidade", "Campo Obrigatório!", _cidadeController),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                HelperWidgets.createTextForm("Estado", "Campo Obrigatório!", _estadoController),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                HelperWidgets.createTextForm("CEP", "Campo Obrigatório!", _cepController),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                HelperWidgets.createTextForm("Ponto de Referência", "Campo Opcional", _pontoReferenciaController),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                HelperWidgets.createTextForm("Telefone", "Campo Opcional", _telefoneController),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                HelperWidgets.createTextForm("CPF", "Campo Opcional", _cpfController),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                HelperWidgets.createTextForm("CNPJ", "Campo Opcional", _cnpjController),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
