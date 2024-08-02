import 'package:flutter/material.dart';
import 'package:flutter_app_oficina_mecanica_template/data/database_provider.dart';
import 'package:flutter_app_oficina_mecanica_template/domain/models/veiculos_model.dart';
import 'package:flutter_app_oficina_mecanica_template/domain/repositories/repository_sqlite.dart';
import 'package:flutter_app_oficina_mecanica_template/presentation/widgets/helper_widgets.dart';

class VeiculoArguments {
  final int idCliente;
  final Veiculos? veiculo;

  VeiculoArguments({required this.idCliente, this.veiculo});
}

class VeiculosFormScreen extends StatefulWidget {
  static const String routeName = "veiculosForm";

  const VeiculosFormScreen({Key? key}) : super(key: key);

  @override
  _VeiculosFormScreenState createState() => _VeiculosFormScreenState();
}

class _VeiculosFormScreenState extends State<VeiculosFormScreen> {
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();

  final TextEditingController _placaController = TextEditingController();
  final TextEditingController _marcaController = TextEditingController();
  final TextEditingController _modeloController = TextEditingController();
  final TextEditingController _corController = TextEditingController();
  final TextEditingController _anoController = TextEditingController();

  Veiculos _veiculos = Veiculos();

  DatabaseProvider _databaseProvider = DatabaseProvider();
  late RepositorySQLite _veiculoRepository;

  int? _idCliente;

  @override
  void initState() {
    super.initState();
    initDatabase();
  }

  void initDatabase() async {
    _veiculoRepository = RepositorySQLite(_databaseProvider);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arguments = ModalRoute.of(context)?.settings.arguments as VeiculoArguments?;
    if (arguments != null) {
      _idCliente = arguments.idCliente;
      final veiculo = arguments.veiculo;
      if (veiculo != null) {
        _veiculos = veiculo;
        _placaController.text = veiculo.placa ?? '';
        _marcaController.text = veiculo.marca ?? '';
        _modeloController.text = veiculo.modelo ?? '';
        _corController.text = veiculo.cor ?? '';
        _anoController.text = veiculo.ano?.toString() ?? '';
      }
    }
  }

  void save() async {
    _veiculos.placa = _placaController.text;
    _veiculos.marca = _marcaController.text;
    _veiculos.modelo = _modeloController.text;
    _veiculos.cor = _corController.text;
    _veiculos.ano = int.tryParse(_anoController.text);

    if (_idCliente != null) {
      _veiculos.idCliente = _idCliente; // Associando o veículo ao cliente
    }

    if (_veiculos.idVeiculo == null) {
      await _veiculoRepository.insert(_veiculos);
    } else {
      await _veiculoRepository.update(_veiculos);
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
            icon: const Icon(Icons.check, color: Colors.blue,),
          ),
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.cancel, color: Colors.red,),
          ),
        ],
        title: const Text('Cadastro de Veículos'),
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
                HelperWidgets.createTextForm("Placa", "Campo Obrigatório!", _placaController),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                HelperWidgets.createTextForm("Marca", "Campo Obrigatório!", _marcaController),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                HelperWidgets.createTextForm("Modelo", "Campo Obrigatório!", _modeloController),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                HelperWidgets.createTextForm("Cor", "Campo Obrigatório!", _corController),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                HelperWidgets.createTextForm("Ano", "Campo Obrigatório!", _anoController),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
