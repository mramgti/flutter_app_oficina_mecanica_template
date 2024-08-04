// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_oficina_mecanica_template/data/database_provider.dart';
import 'package:flutter_app_oficina_mecanica_template/domain/models/entity.dart';
import 'package:flutter_app_oficina_mecanica_template/domain/models/estoque_peca_servico_model.dart';
import 'package:flutter_app_oficina_mecanica_template/domain/models/tipo_peca_servico_model.dart';
import 'package:flutter_app_oficina_mecanica_template/domain/models/fornecedor_estoque_pecas_model.dart';
import 'package:flutter_app_oficina_mecanica_template/domain/models/fornecedor_model.dart';
import 'package:flutter_app_oficina_mecanica_template/domain/repositories/repository_sqlite.dart';

class EstoquePecaServicoFormScreen extends StatefulWidget {
  static const String routeName = "estoquePecaServicoForm";

  const EstoquePecaServicoFormScreen({Key? key}) : super(key: key);

  @override
  _EstoquePecaServicoFormScreenState createState() =>
      _EstoquePecaServicoFormScreenState();
}

class _EstoquePecaServicoFormScreenState
    extends State<EstoquePecaServicoFormScreen> {
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();

  TextEditingController _nomeController = TextEditingController();
  TextEditingController _precoCompraController = TextEditingController();
  TextEditingController _precoVendaController = TextEditingController();
  TextEditingController _quantidadeController = TextEditingController();

  EstoquePecaServico _estoquePecaServico = EstoquePecaServico();
  List<TipoPecaServico> _tiposPecaServico = [];
  TipoPecaServico? _selectedTipoPecaServico;

  List<Fornecedor> _fornecedores = [];
  Fornecedor? _selectedFornecedor;

  DatabaseProvider _databaseProvider = DatabaseProvider();
  late RepositorySQLite _repository;
  late RepositorySQLite _tiposPecaServicoRepository;
  late RepositorySQLite _fornecedoresRepository;

  @override
  void initState() {
    super.initState();
    initDatabase();
    _loadFornecedores();
  }

  void initDatabase() async {
    _repository = RepositorySQLite(_databaseProvider);
    _tiposPecaServicoRepository = RepositorySQLite(_databaseProvider);

    List<Entity> tiposRes =
        await _tiposPecaServicoRepository.findAll(TipoPecaServico());
    setState(() {
      _tiposPecaServico = tiposRes.whereType<TipoPecaServico>().toList();

      if (_tiposPecaServico.isNotEmpty) {
        _selectedTipoPecaServico = _tiposPecaServico.firstWhere(
          (tipo) =>
              tipo.idTipoPecaServico == _estoquePecaServico.idTipoPecaServico,
          orElse: () => _tiposPecaServico.first,
        );
      } else {
        _selectedTipoPecaServico = null;
      }
    });
  }

  void _loadFornecedores() async {
    _fornecedoresRepository = RepositorySQLite(_databaseProvider);
    List<Entity> fornecedoresRes =
        await _fornecedoresRepository.findAll(Fornecedor());
    setState(() {
      _fornecedores = fornecedoresRes.whereType<Fornecedor>().toList();
      // Se não há fornecedores carregados, defina _selectedFornecedor como null
      _selectedFornecedor =
          _fornecedores.isNotEmpty ? _fornecedores.first : null;
    });
  }

  void save() async {
    _estoquePecaServico.nome = _nomeController.text;
    _estoquePecaServico.precoCompra =
        double.tryParse(_precoCompraController.text);
    _estoquePecaServico.precoVenda =
        double.tryParse(_precoVendaController.text);
    _estoquePecaServico.quantidade = int.tryParse(_quantidadeController.text);
    _estoquePecaServico.idTipoPecaServico =
        _selectedTipoPecaServico?.idTipoPecaServico;

    // Acessa o banco de dados
    final db = await _databaseProvider.database;

    // Salvar ou atualizar o EstoquePecaServico
    if (_estoquePecaServico.idPecaServico == null) {
      int id =
          await db.insert('estoquePecaServico', _estoquePecaServico.toMap());
      _estoquePecaServico.idPecaServico = id; // Atualiza o ID do registro
    } else {
      await db.update(
        'estoquePecaServico',
        _estoquePecaServico.toMap(),
        where: 'idPecaServico = ?',
        whereArgs: [_estoquePecaServico.idPecaServico],
      );
    }

    // Remover relação existente na tabela FornecedorEstoquePecas, se necessário
    if (_selectedFornecedor != null) {
      await db.delete(
        'fornecedorEstoquePecas',
        where: 'idPecaServico = ?',
        whereArgs: [_estoquePecaServico.idPecaServico],
      );

      FornecedorEstoquePecas fornecedorEstoquePecas = FornecedorEstoquePecas(
        idFornecedor: _selectedFornecedor!.idFornecedor,
        idPecaServico: _estoquePecaServico.idPecaServico!,
      );

      // Inserir na tabela FornecedorEstoquePecas
      await db.insert('fornecedorEstoquePecas', fornecedorEstoquePecas.toMap());
    }
  }

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context)!.settings.arguments != null) {
      EstoquePecaServico item =
          ModalRoute.of(context)!.settings.arguments as EstoquePecaServico;
      _estoquePecaServico.idPecaServico = item.idPecaServico;
      _nomeController.text = item.nome ?? '';
      _precoCompraController.text = item.precoCompra?.toString() ?? '';
      _precoVendaController.text = item.precoVenda?.toString() ?? '';
      _quantidadeController.text = item.quantidade?.toString() ?? '';

      if (_tiposPecaServico.isNotEmpty) {
        _selectedTipoPecaServico = _tiposPecaServico.firstWhere(
          (tipo) => tipo.idTipoPecaServico == item.idTipoPecaServico,
          orElse: () => _tiposPecaServico.first,
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Peça / Serviço'),
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
      ),
      body: Form(
        key: _formState,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            _createNomeTextField(context),
            _createPrecoCompraTextField(context),
            _createPrecoVendaTextField(context),
            _createQuantidadeTextField(context),
            SizedBox(height: 20),
            _createFornecedorDropdown(),
            SizedBox(height: 20),
            _createTipoPecaServicoDropdown(),
          ],
        ),
      ),
    );
  }

  Widget _createNomeTextField(BuildContext context) {
    return TextFormField(
      controller: _nomeController,
      decoration: InputDecoration(
        labelText: "Nome",
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Este campo é obrigatório";
        }
        return null;
      },
    );
  }

  Widget _createPrecoCompraTextField(BuildContext context) {
    return TextFormField(
      controller: _precoCompraController,
      decoration: InputDecoration(
        labelText: "Preço de Compra",
      ),
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Este campo é obrigatório";
        }
        return null;
      },
    );
  }

  Widget _createPrecoVendaTextField(BuildContext context) {
    return TextFormField(
      controller: _precoVendaController,
      decoration: InputDecoration(
        labelText: "Preço de Venda",
      ),
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Este campo é obrigatório";
        }
        return null;
      },
    );
  }

  Widget _createQuantidadeTextField(BuildContext context) {
    return TextFormField(
      controller: _quantidadeController,
      decoration: InputDecoration(
        labelText: "Quantidade",
      ),
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Este campo é obrigatório";
        }
        return null;
      },
    );
  }

  Widget _createFornecedorDropdown() {
    return DropdownButtonFormField<Fornecedor>(
      value: _selectedFornecedor,
      decoration: InputDecoration(
        labelText: "Fornecedor",
        border: OutlineInputBorder(),
      ),
      items: _fornecedores.map((fornecedor) {
        return DropdownMenuItem<Fornecedor>(
          value: fornecedor,
          child: Text(fornecedor.nome ?? ''),
        );
      }).toList(),
      onChanged: (Fornecedor? newFornecedor) {
        setState(() {
          _selectedFornecedor = newFornecedor;
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

  Widget _createTipoPecaServicoDropdown() {
    return DropdownButtonFormField<TipoPecaServico>(
      value: _selectedTipoPecaServico,
      decoration: InputDecoration(
        labelText: "Tipo de Peça/Serviço",
        border: OutlineInputBorder(),
      ),
      items: _tiposPecaServico.map((tipo) {
        return DropdownMenuItem<TipoPecaServico>(
          value: tipo,
          child: Text(tipo.nome ?? ''),
        );
      }).toList(),
      onChanged: (TipoPecaServico? newTipo) {
        setState(() {
          _selectedTipoPecaServico = newTipo;
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
