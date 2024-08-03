import 'package:flutter/material.dart';
import 'package:flutter_app_oficina_mecanica_template/data/database_provider.dart';
import 'package:flutter_app_oficina_mecanica_template/domain/models/clientes_model.dart';
import 'package:flutter_app_oficina_mecanica_template/domain/models/ordem_servico_model.dart';
import 'package:flutter_app_oficina_mecanica_template/domain/models/funcionarios_model.dart';
import 'package:flutter_app_oficina_mecanica_template/domain/models/tipo_pagamento_model.dart';
import 'package:flutter_app_oficina_mecanica_template/domain/models/tipo_status_model.dart';
import 'package:flutter_app_oficina_mecanica_template/domain/models/veiculos_model.dart';
import 'package:flutter_app_oficina_mecanica_template/domain/repositories/repository_sqlite.dart';

class OrdemServicoFormScreen extends StatefulWidget {
  static const String routeName = "ordemServicoForm";

  const OrdemServicoFormScreen({Key? key}) : super(key: key);

  @override
  _OrdemServicoFormScreenState createState() => _OrdemServicoFormScreenState();
}

class _OrdemServicoFormScreenState extends State<OrdemServicoFormScreen> {
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();

  final TextEditingController _quilometragemController =
      TextEditingController();
  final TextEditingController _valorPagoController = TextEditingController();
  final TextEditingController _dataHoraEntregaVeiculoController =
      TextEditingController();
  final TextEditingController _dataHoraInicioServicoController =
      TextEditingController();
  final TextEditingController _dataHoraFimServicoController =
      TextEditingController();

  OrdemServico _ordemServico = OrdemServico();
  List<Clientes> _clientes = [];
  List<Funcionarios> _funcionarios = [];
  List<Veiculos> _veiculos = [];
  List<TipoPagamento> _tiposPagamento = [];
  List<TipoStatus> _tiposStatus = [];
  Clientes? _selectedCliente;
  Funcionarios? _selectedFuncionario;
  Veiculos? _selectedVeiculo;
  TipoPagamento? _selectedTipoPagamento;
  TipoStatus? _selectedTipoStatus;

  DatabaseProvider _databaseProvider = DatabaseProvider();
  late RepositorySQLite<OrdemServico> _ordemServicoRepository;
  late RepositorySQLite<Clientes> _clienteRepository;
  late RepositorySQLite<Funcionarios> _funcionarioRepository;
  late RepositorySQLite<Veiculos> _veiculoRepository;
  late RepositorySQLite<TipoPagamento> _tipoPagamentoRepository;
  late RepositorySQLite<TipoStatus> _tipoStatusRepository;

  @override
  void initState() {
    super.initState();
    initDatabase();
  }

  void initDatabase() async {
    await _databaseProvider.open();
    _ordemServicoRepository = RepositorySQLite(_databaseProvider);
    _clienteRepository = RepositorySQLite(_databaseProvider);
    _funcionarioRepository = RepositorySQLite(_databaseProvider);
    _veiculoRepository = RepositorySQLite(_databaseProvider);
    _tipoPagamentoRepository = RepositorySQLite(_databaseProvider);
    _tipoStatusRepository = RepositorySQLite(_databaseProvider);

    List<Clientes> clientesRes = await _clienteRepository.findAll(Clientes());
    List<Funcionarios> funcionariosRes =
        await _funcionarioRepository.findAll(Funcionarios());
    List<Veiculos> veiculosRes = await _veiculoRepository.findAll(Veiculos());
    List<TipoPagamento> tiposPagamentoRes =
        await _tipoPagamentoRepository.findAll(TipoPagamento());
    List<TipoStatus> tiposStatusRes =
        await _tipoStatusRepository.findAll(TipoStatus());

    setState(() {
      _clientes = clientesRes;
      _funcionarios = funcionariosRes;
      _veiculos = veiculosRes;
      _tiposPagamento = tiposPagamentoRes;
      _tiposStatus = tiposStatusRes;
      _initializeFields();
    });
  }

  void _initializeFields() {
    _ordemServico =
        ModalRoute.of(context)?.settings.arguments as OrdemServico? ??
            OrdemServico();

    _quilometragemController.text =
        _ordemServico.quilometragem?.toString() ?? '';
    _valorPagoController.text = _ordemServico.valorPago?.toString() ?? '';
    _dataHoraEntregaVeiculoController.text =
        _ordemServico.dataHoraEntregaVeiculo ?? '';
    _dataHoraInicioServicoController.text =
        _ordemServico.dataHoraInicioServico ?? '';
    _dataHoraFimServicoController.text = _ordemServico.dataHoraFimServico ?? '';

    _selectedCliente = _clientes.isNotEmpty
        ? _clientes.firstWhere(
            (cliente) => cliente.idCliente == _ordemServico.idCliente,
            orElse: () => _clientes
                .first,
          )
        : null;

    _selectedFuncionario = _funcionarios.isNotEmpty
        ? _funcionarios.firstWhere(
            (funcionario) =>
                funcionario.idFuncionario == _ordemServico.idFuncionario,
            orElse: () => _funcionarios
                .first,
          )
        : null;

    _selectedVeiculo = _veiculos.isNotEmpty
        ? _veiculos.firstWhere(
            (veiculo) => veiculo.idVeiculo == _ordemServico.idVeiculo,
            orElse: () => _veiculos
                .first,
          )
        : null;

    _selectedTipoPagamento = _tiposPagamento.isNotEmpty
        ? _tiposPagamento.firstWhere(
            (tipoPagamento) =>
                tipoPagamento.idTipoPagamento == _ordemServico.idTipoPagamento,
            orElse: () => _tiposPagamento
                .first,
          )
        : null;

    _selectedTipoStatus = _tiposStatus.isNotEmpty
        ? _tiposStatus.firstWhere(
            (tipoStatus) =>
                tipoStatus.idTipoStatus == _ordemServico.idTipoStatus,
            orElse: () => _tiposStatus
                .first,
          )
        : null;

    setState(() {});
  }

  void _onClienteChanged(Clientes? selectedCliente) async {
    if (selectedCliente != null) {
      int clienteId = selectedCliente.idCliente ?? 0;
      List<Veiculos> veiculosRes =
          await _veiculoRepository.findVeiculosByClienteId(clienteId);
      setState(() {
        _selectedCliente = selectedCliente;
        _veiculos = veiculosRes;
        _selectedVeiculo = null;
      });
    } else {
      setState(() {
        _selectedCliente = null;
        _veiculos = [];
        _selectedVeiculo = null;
      });
    }
  }

  void save() async {
    _ordemServico.quilometragem =
        int.tryParse(_quilometragemController.text) ?? 0;
    _ordemServico.valorPago = double.tryParse(_valorPagoController.text) ?? 0.0;
    _ordemServico.dataHoraEntregaVeiculo =
        _dataHoraEntregaVeiculoController.text;
    _ordemServico.dataHoraInicioServico = _dataHoraInicioServicoController.text;
    _ordemServico.dataHoraFimServico = _dataHoraFimServicoController.text;
    _ordemServico.idCliente = _selectedCliente?.idCliente;
    _ordemServico.idFuncionario = _selectedFuncionario?.idFuncionario;
    _ordemServico.idVeiculo = _selectedVeiculo?.idVeiculo;
    _ordemServico.idTipoPagamento = _selectedTipoPagamento?.idTipoPagamento;
    _ordemServico.idTipoStatus = _selectedTipoStatus?.idTipoStatus;

    if (_ordemServico.idOrdemServico == null) {
      await _ordemServicoRepository.insert(_ordemServico);
    } else {
      await _ordemServicoRepository.update(_ordemServico);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_clientes.isEmpty ||
        _funcionarios.isEmpty ||
        _veiculos.isEmpty ||
        _tiposPagamento.isEmpty ||
        _tiposStatus.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro de Ordem de Serviço'),
        ),
        body: Center(child: CircularProgressIndicator()),
      );
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
        title: const Text('Cadastro de Ordem de Serviço'),
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
              _createDropdown<Clientes>(
                "Cliente",
                _selectedCliente,
                _clientes,
                (value) {
                  _onClienteChanged(value as Clientes?);
                },
              ),
              _createDropdown<Veiculos>(
                "Veículo",
                _selectedVeiculo,
                _veiculos,
                (value) {
                  setState(() {
                    _selectedVeiculo = value as Veiculos?;
                  });
                },
              ),
              _createDropdown<Funcionarios>(
                "Funcionário",
                _selectedFuncionario,
                _funcionarios,
                (value) {
                  setState(() {
                    _selectedFuncionario = value as Funcionarios?;
                  });
                },
              ),
              _createDropdown<TipoPagamento>(
                "Tipo de Pagamento",
                _selectedTipoPagamento,
                _tiposPagamento,
                (value) {
                  setState(() {
                    _selectedTipoPagamento = value as TipoPagamento?;
                  });
                },
              ),
              _createDropdown<TipoStatus>(
                "Tipo de Status",
                _selectedTipoStatus,
                _tiposStatus,
                (value) {
                  setState(() {
                    _selectedTipoStatus = value as TipoStatus?;
                  });
                },
              ),
              _createTextField("Quilometragem", _quilometragemController),
              _createTextField("Valor Pago", _valorPagoController),
              _createTextField("Data/Hora Entrega Veículo",
                  _dataHoraEntregaVeiculoController),
              _createTextField(
                  "Data/Hora Início Serviço", _dataHoraInicioServicoController),
              _createTextField(
                  "Data/Hora Fim Serviço", _dataHoraFimServicoController),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _createTextField(String label, TextEditingController controller) {
    return TextFormField(
      decoration: InputDecoration(labelText: label),
      controller: controller,
      keyboardType: label == "Valor Pago"
          ? TextInputType.numberWithOptions(decimal: true)
          : TextInputType.number,
      validator: (value) =>
          value == null || value.isEmpty ? "Campo obrigatório" : null,
    );
  }

  Widget _createDropdown<T>(
      String label, T? selectedValue, List<T> items, Function(T?) onChanged) {
    return DropdownButtonFormField<T>(
      decoration: InputDecoration(labelText: label),
      value: selectedValue,
      items: items.map((T item) {
        return DropdownMenuItem<T>(
          value: item,
          child: Text(item.toString()),
        );
      }).toList(),
      onChanged: onChanged,
      validator: (value) => value == null ? "Campo obrigatório" : null,
    );
  }
}
