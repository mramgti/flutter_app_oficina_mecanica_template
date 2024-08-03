import 'package:flutter/material.dart';
import 'package:flutter_app_oficina_mecanica_template/data/database_provider.dart';
import 'package:flutter_app_oficina_mecanica_template/domain/models/entity.dart';
import 'package:flutter_app_oficina_mecanica_template/domain/models/funcionarios_model.dart';
import 'package:flutter_app_oficina_mecanica_template/domain/models/tipo_funcionario_model.dart';
import 'package:flutter_app_oficina_mecanica_template/domain/repositories/repository_sqlite.dart';
import 'package:flutter_app_oficina_mecanica_template/presentation/widgets/helper_widgets.dart';

class FuncionariosFormScreen extends StatefulWidget {
  static const String routeName = "funcionariosForm";

  const FuncionariosFormScreen({Key? key}) : super(key: key);

  @override
  _FuncionariosFormScreenState createState() => _FuncionariosFormScreenState();
}

class _FuncionariosFormScreenState extends State<FuncionariosFormScreen> {
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();

  TextEditingController _nomeController = TextEditingController();
  TextEditingController _senhaController = TextEditingController();
  TextEditingController _cpfController = TextEditingController();
  TextEditingController _dataNascimentoController = TextEditingController();
  TextEditingController _dataContratacaoController = TextEditingController();
  TextEditingController _salarioController = TextEditingController();
  TextEditingController _dataDemissaoController = TextEditingController();

  Funcionarios _funcionario = Funcionarios();
  List<TipoFuncionario> _tiposFuncionario = [];
  TipoFuncionario? _selectedTipoFuncionario;

  DatabaseProvider _databaseProvider = DatabaseProvider();
  late RepositorySQLite _funcionariosRepository;
  late RepositorySQLite _tiposFuncionarioRepository;

  @override
  void initState() {
    super.initState();
    initDatabase();
  }

  void initDatabase() async {
    _funcionariosRepository = RepositorySQLite(_databaseProvider);
    _tiposFuncionarioRepository = RepositorySQLite(_databaseProvider);

    List<Entity> tiposRes =
        await _tiposFuncionarioRepository.findAll(TipoFuncionario());
    setState(() {
      _tiposFuncionario = tiposRes.whereType<TipoFuncionario>().toList();

      if (_tiposFuncionario.isNotEmpty) {
        _selectedTipoFuncionario = _tiposFuncionario.firstWhere(
          (tipo) => tipo.idTipoFuncionario == _funcionario.idTipoFuncionario,
          orElse: () => _tiposFuncionario.first,
        );
      } else {
        _selectedTipoFuncionario = null;
      }
    });
  }

  void save() async {
    _funcionario.nome = _nomeController.text;
    _funcionario.senha = _senhaController.text;
    _funcionario.cpf = _cpfController.text;
    _funcionario.dataNascimento = _dataNascimentoController.text;
    _funcionario.dataContratacao = _dataContratacaoController.text;
    _funcionario.salario = double.tryParse(_salarioController.text);
    _funcionario.dataDemissao = _dataDemissaoController.text;
    _funcionario.idTipoFuncionario =
        _selectedTipoFuncionario?.idTipoFuncionario;

    if (_funcionario.idFuncionario == null) {
      await _funcionariosRepository.insert(_funcionario);
    } else {
      await _funcionariosRepository.update(_funcionario);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context)!.settings.arguments != null) {
      Funcionarios funcionario =
          ModalRoute.of(context)!.settings.arguments as Funcionarios;
      _funcionario.idFuncionario = funcionario.idFuncionario;
      _nomeController.text = funcionario.nome ?? '';
      _senhaController.text = funcionario.senha ?? '';
      _cpfController.text = funcionario.cpf ?? '';
      _dataNascimentoController.text = funcionario.dataNascimento ?? '';
      _dataContratacaoController.text = funcionario.dataContratacao ?? '';
      _salarioController.text = funcionario.salario?.toString() ?? '';
      _dataDemissaoController.text = funcionario.dataDemissao ?? '';

      if (_tiposFuncionario.isNotEmpty) {
        _selectedTipoFuncionario = _tiposFuncionario.firstWhere(
          (tipo) => tipo.idTipoFuncionario == funcionario.idTipoFuncionario,
          orElse: () => _tiposFuncionario.first,
        );
      }
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
        title: const Text('Cadastro de Funcionários'),
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
            HelperWidgets.createTextForm(
                "Nome", "Campo Obrigatório!", _nomeController),
            HelperWidgets.createTextForm(
                "Senha", "Campo Obrigatório!", _senhaController),
            HelperWidgets.createTextForm(
                "CPF", "Campo Obrigatório!", _cpfController),
            HelperWidgets.createTextForm("Data de Nascimento",
                "Campo Obrigatório!", _dataNascimentoController),
            HelperWidgets.createTextForm("Data de Contratação",
                "Campo Obrigatório!", _dataContratacaoController),
            HelperWidgets.createTextForm(
                "Salário", "Campo Obrigatório!", _salarioController),
            HelperWidgets.createTextForm(
                "Data de Demissão", "", _dataDemissaoController),
            const SizedBox(height: 16),
            _createTipoFuncionarioDropdown(),
          ],
        ),
      ),
    );
  }

  Widget _createTipoFuncionarioDropdown() {
    return DropdownButtonFormField<TipoFuncionario>(
      value: _selectedTipoFuncionario,
      decoration: InputDecoration(
        labelText: "Tipo de Funcionário",
        border: OutlineInputBorder(),
      ),
      items: _tiposFuncionario.map((tipo) {
        return DropdownMenuItem<TipoFuncionario>(
          value: tipo,
          child: Text(tipo.nome ?? ''),
        );
      }).toList(),
      onChanged: (TipoFuncionario? newTipo) {
        setState(() {
          _selectedTipoFuncionario = newTipo;
        });
      },
      validator: (value) {
        if (value == null) {
          return 'Campo obrigatório';
        }
        return null;
      },
    );
  }
}
