import 'package:flutter/material.dart';
import 'package:flutter_app_oficina_mecanica_template/data/database_provider.dart';
import 'package:flutter_app_oficina_mecanica_template/domain/models/clientes_model.dart';
import 'package:flutter_app_oficina_mecanica_template/domain/models/ordem_servico_model.dart';
import 'package:flutter_app_oficina_mecanica_template/domain/models/funcionarios_model.dart';
import 'package:flutter_app_oficina_mecanica_template/domain/models/tipo_status_model.dart';
import 'package:flutter_app_oficina_mecanica_template/domain/models/veiculos_model.dart';
import 'package:flutter_app_oficina_mecanica_template/domain/repositories/repository_sqlite.dart';
import 'package:flutter_app_oficina_mecanica_template/presentation/screen/ordem_servico/ordem_servico_form_screen.dart';

class OrdemServicoSearchScreen extends StatefulWidget {
  static const String routeName = "ordemServico";

  const OrdemServicoSearchScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _OrdemServicoSearchScreenState();
}

class _OrdemServicoSearchScreenState extends State<OrdemServicoSearchScreen> {
  List<OrdemServico> _results = [];
  List<OrdemServico> _filteredResults = [];
  List<Clientes> _clientes = [];
  List<Funcionarios> _funcionarios = [];
  List<Veiculos> _veiculos = [];
  List<TipoStatus> _tiposStatus = [];
  Clientes? _selectedCliente;
  Funcionarios? _selectedFuncionario;
  Veiculos? _selectedVeiculo;
  TipoStatus? _selectedTipoStatus;

  late RepositorySQLite<OrdemServico> _ordemServicoRepository;
  late RepositorySQLite<Clientes> _clienteRepository;
  late RepositorySQLite<Funcionarios> _funcionarioRepository;
  late RepositorySQLite<Veiculos> _veiculoRepository;
  late RepositorySQLite<TipoStatus> _tipoStatusRepository;

  @override
  void initState() {
    super.initState();
    initDatabase();
  
    _selectedCliente = null;
    _selectedFuncionario = null;
    _selectedVeiculo = null;
    _selectedTipoStatus = null;
  }

  void initDatabase() async {
    final databaseProvider = DatabaseProvider();
    await databaseProvider.open();
    _ordemServicoRepository = RepositorySQLite(databaseProvider);
    _clienteRepository = RepositorySQLite(databaseProvider);
    _funcionarioRepository = RepositorySQLite(databaseProvider);
    _veiculoRepository = RepositorySQLite(databaseProvider);
    _tipoStatusRepository = RepositorySQLite(databaseProvider);

    await _fetchAll();
  }

  Future<void> _fetchAll() async {
    List<OrdemServico> ordemServicoList = await _ordemServicoRepository.findAll(OrdemServico());
    List<Clientes> clientesList = await _clienteRepository.findAll(Clientes());
    List<Funcionarios> funcionariosList = await _funcionarioRepository.findAll(Funcionarios());
    List<Veiculos> veiculosList = await _veiculoRepository.findAll(Veiculos());
    List<TipoStatus> tiposStatusList = await _tipoStatusRepository.findAll(TipoStatus());

    setState(() {
      _results = ordemServicoList;
      _filteredResults = ordemServicoList;
      _clientes = clientesList;
      _funcionarios = funcionariosList;
      _veiculos = veiculosList;
      _tiposStatus = tiposStatusList;
    });
  }

  void _filterResults() {
    setState(() {
      _filteredResults = _results.where((ordemServico) {
        bool matchCliente = _selectedCliente == null || ordemServico.idCliente == _selectedCliente?.idCliente;
        bool matchFuncionario = _selectedFuncionario == null || ordemServico.idFuncionario == _selectedFuncionario?.idFuncionario;
        bool matchVeiculo = _selectedVeiculo == null || ordemServico.idVeiculo == _selectedVeiculo?.idVeiculo;
        bool matchTipoStatus = _selectedTipoStatus == null || ordemServico.idTipoStatus == _selectedTipoStatus?.idTipoStatus;

        return matchCliente && matchFuncionario && matchVeiculo && matchTipoStatus;
      }).toList();
    });
  }

  void _clearFilters() {
    setState(() {
      _selectedCliente = null;
      _selectedFuncionario = null;
      _selectedVeiculo = null;
      _selectedTipoStatus = null;
      _filterResults();
    });
  }

  String? _getClienteName(int? idCliente) {
    return _clientes.firstWhere((cliente) => cliente.idCliente == idCliente, orElse: () => Clientes()).nome;
  }

  String? _getVeiculoName(int? idVeiculo) {
    return _veiculos.firstWhere((veiculo) => veiculo.idVeiculo == idVeiculo, orElse: () => Veiculos()).modelo;
  }

  String? _getStatusDescription(int? idStatus) {
    return _tiposStatus.firstWhere((status) => status.idTipoStatus == idStatus, orElse: () => TipoStatus()).nome;
  }

  Color _getStatusColor(String statusDescription) {
    switch (statusDescription) {
      case 'Concluído':
        return Colors.green;
      case 'Em aberto':
        return Colors.orange;
      case 'Em andamento':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ordens de Serviço"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Pesquisar por:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _createDropdown<Clientes>(
              "Cliente",
              _selectedCliente,
              _clientes,
              (value) {
                setState(() {
                  _selectedCliente = value as Clientes?;
                  _filterResults();
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
                  _filterResults();
                });
              },
            ),
            _createDropdown<Veiculos>(
              "Veículo",
              _selectedVeiculo,
              _veiculos,
              (value) {
                setState(() {
                  _selectedVeiculo = value as Veiculos?;
                  _filterResults();
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
                  _filterResults();
                });
              },
            ),
            const SizedBox(height: 34),

            Text(
              "Resultados",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _createListView(context),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue[400],
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () async {
          _clearFilters(); // Limpa os filtros antes de navegar
          await Navigator.pushNamed(context, OrdemServicoFormScreen.routeName);
          await _fetchAll();
        },
      ),
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

  Widget _createListView(BuildContext context) {
    if (_filteredResults.isEmpty) {
      return const Text(
        "Sem dados disponíveis",
        style: TextStyle(fontSize: 20),
      );
    } else {
      return Expanded(
        child: ListView.builder(
          itemCount: _filteredResults.length,
          itemBuilder: (context, index) => _createItem(context, index),
        ),
      );
    }
  }

  Widget _createItem(BuildContext context, int index) {
    OrdemServico ordemServico = _filteredResults[index];
    String? clienteName = _getClienteName(ordemServico.idCliente);
    String? veiculoName = _getVeiculoName(ordemServico.idVeiculo);
    String? statusDescription = _getStatusDescription(ordemServico.idTipoStatus);

    return Card(
      child: ListTile(
        title: Text('Ordem ${ordemServico.idOrdemServico} - Cliente: $clienteName'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Veículo: $veiculoName'),
            Row(
              children: [
                Text('Status: '),
                Text(
                  statusDescription!,
                  style: TextStyle(color: _getStatusColor(statusDescription)),
                ),
              ],
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () async {
                await Navigator.of(context).pushNamed(
                    OrdemServicoFormScreen.routeName,
                    arguments: ordemServico);
                await _fetchAll();
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () async {
                _showDeleteConfirmationDialog(context, ordemServico);
              },
            ),
          ],
        ),
        onTap: () async {
          await Navigator.of(context).pushNamed(
              OrdemServicoFormScreen.routeName,
              arguments: ordemServico);
          await _fetchAll();
        },
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, OrdemServico ordemServico) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Confirmar Exclusão"),
          content: const Text("Tem certeza de que deseja excluir esta ordem de serviço?"),
          actions: [
            TextButton(
              onPressed: () async {
                await _ordemServicoRepository.delete(ordemServico);
                Navigator.of(context).pop();
                await _fetchAll();
              },
              child: const Text("Excluir"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancelar"),
            ),
          ],
        );
      },
    );
  }
}
