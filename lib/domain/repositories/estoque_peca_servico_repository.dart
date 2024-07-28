import 'package:flutter_app_oficina_mecanica_template/data/database_provider.dart';
import 'package:flutter_app_oficina_mecanica_template/domain/models/estoque_peca_servico_model.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class EstoquePecaServicoRepository {
  late DatabaseProvider databaseProvider;

  EstoquePecaServicoRepository(this.databaseProvider);

  Future<int> insert(EstoquePecaServico entity) async {
    try {
      await databaseProvider.open();
      Database dt = databaseProvider.database;
      return await dt.insert("EstoquePecaServico", entity.toMap());
    } on Exception catch (e) {
      throw Exception(e);
    } finally {
      if (databaseProvider.database.isOpen) {
        databaseProvider.database.close();
      }
    }
  }

  Future<int> delete(EstoquePecaServico entity) async {
    try {
      await databaseProvider.open();
      Database dt = databaseProvider.database;
      return await dt.delete("EstoquePecaServico", where: "id = ?", whereArgs: ["${entity.id}"]);
    } on Exception catch (e) {
      throw Exception(e);
    } finally {
      if (databaseProvider.database.isOpen) {
        databaseProvider.database.close();
      }
    }
  }

  Future<int> update(EstoquePecaServico entity) async {
    try {
      await databaseProvider.open();
      Database dt = databaseProvider.database;
      return await dt.update("EstoquePecaServico", entity.toMap(), where: "id = ?", whereArgs: ["${entity.id}"]);
    } on Exception catch (e) {
      throw Exception(e);
    } finally {
      if (databaseProvider.database.isOpen) {
        databaseProvider.database.close();
      }
    }
  }

  Future<EstoquePecaServico> findById(int id) async {
    var estoquePecaServico = EstoquePecaServico();
    try {
      await databaseProvider.open();
      Database dt = databaseProvider.database;
      List<Map<String, Object?>> result = await dt.rawQuery("SELECT * FROM EstoquePecaServico WHERE id = ?", [id]);
      
      if (result.isNotEmpty) {
        Map<String, Object?> item = result[0];
        estoquePecaServico = EstoquePecaServico.fromMap(item);
      }
    } on Exception catch (e) {
      throw Exception(e);
    } finally {
      if (databaseProvider.database.isOpen) {
        databaseProvider.database.close();
      }
    }
    return estoquePecaServico;
  }

  Future<List<EstoquePecaServico>> findAll() async {
    await databaseProvider.open();
    Database dt = databaseProvider.database;
    List<Map<String, Object?>> result = await dt.rawQuery("SELECT * FROM EstoquePecaServico");

    List<EstoquePecaServico> estoquePecaServicoResults = [];
    if (result.isNotEmpty) {
      for (var item in result) {
        EstoquePecaServico estoquePecaServico = EstoquePecaServico.fromMap(item);
        estoquePecaServicoResults.add(estoquePecaServico);
      }
    }
    return estoquePecaServicoResults;
  }
}
