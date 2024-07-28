import 'package:flutter_app_oficina_mecanica_template/data/database_provider.dart';
import 'package:flutter_app_oficina_mecanica_template/domain/models/tipo_peca_servico_model.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class TipoPecaServicoRepository {
  late DatabaseProvider databaseProvider;

  TipoPecaServicoRepository(this.databaseProvider);

  Future<int> insert(TipoPecaServico entity) async {
    try {
      await databaseProvider.open();
      Database dt = databaseProvider.database;
      return await dt.insert("TipoPecaServico", entity.toMap());
    } on Exception catch (e) {
      throw Exception(e);
    } finally {
      if (databaseProvider.database.isOpen) {
        databaseProvider.database.close();
      }
    }
  }

  Future<int> delete(TipoPecaServico entity) async {
    try {
      await databaseProvider.open();
      Database dt = databaseProvider.database;
      return await dt.delete("TipoPecaServico", where: "id = ?", whereArgs: ["${entity.id}"]);
    } on Exception catch (e) {
      throw Exception(e);
    } finally {
      if (databaseProvider.database.isOpen) {
        databaseProvider.database.close();
      }
    }
  }

  Future<int> update(TipoPecaServico entity) async {
    try {
      await databaseProvider.open();
      Database dt = databaseProvider.database;
      return await dt.update("TipoPecaServico", entity.toMap(), where: "id = ?", whereArgs: ["${entity.id}"]);
    } on Exception catch (e) {
      throw Exception(e);
    } finally {
      if (databaseProvider.database.isOpen) {
        databaseProvider.database.close();
      }
    }
  }

  Future<TipoPecaServico> findById(int id) async {
    var tipoPecaServico = TipoPecaServico();
    try {
      await databaseProvider.open();
      Database dt = databaseProvider.database;
      List<Map<String, Object?>> result = await dt.rawQuery("SELECT * FROM TipoPecaServico WHERE id = ?", [id]);
      
      if (result.isNotEmpty) {
        Map<String, Object?> item = result[0];
        tipoPecaServico = TipoPecaServico.fromMap(item);
      }
    } on Exception catch (e) {
      throw Exception(e);
    } finally {
      if (databaseProvider.database.isOpen) {
        databaseProvider.database.close();
      }
    }
    return tipoPecaServico;
  }

  Future<List<TipoPecaServico>> findAll() async {
    await databaseProvider.open();
    Database dt = databaseProvider.database;
    List<Map<String, Object?>> result = await dt.rawQuery("SELECT * FROM TipoPecaServico");

    List<TipoPecaServico> tipoPecaServicoResults = [];
    if (result.isNotEmpty) {
      for (var item in result) {
        TipoPecaServico tipoPecaServico = TipoPecaServico.fromMap(item);
        tipoPecaServicoResults.add(tipoPecaServico);
      }
    }
    return tipoPecaServicoResults;
  }
}