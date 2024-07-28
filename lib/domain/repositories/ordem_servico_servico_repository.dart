import 'package:flutter_app_oficina_mecanica_template/data/database_provider.dart';
import 'package:flutter_app_oficina_mecanica_template/domain/models/ordem_servico_servico_model.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class OrdemServicoServicoRepository {
  late DatabaseProvider databaseProvider;

  OrdemServicoServicoRepository(this.databaseProvider);

  Future<int> insert(OrdemServicoServico entity) async {
    try {
      await databaseProvider.open();
      Database dt = databaseProvider.database;
      return await dt.insert("OrdemServicoServico", entity.toMap());
    } on Exception catch (e) {
      throw Exception(e);
    } finally {
      if (databaseProvider.database.isOpen) {
        databaseProvider.database.close();
      }
    }
  }

  Future<int> delete(OrdemServicoServico entity) async {
    try {
      await databaseProvider.open();
      Database dt = databaseProvider.database;
      return await dt.delete("OrdemServicoServico", where: "id = ?", whereArgs: ["${entity.id}"]);
    } on Exception catch (e) {
      throw Exception(e);
    } finally {
      if (databaseProvider.database.isOpen) {
        databaseProvider.database.close();
      }
    }
  }

  Future<int> update(OrdemServicoServico entity) async {
    try {
      await databaseProvider.open();
      Database dt = databaseProvider.database;
      return await dt.update("OrdemServicoServico", entity.toMap(), where: "id = ?", whereArgs: ["${entity.id}"]);
    } on Exception catch (e) {
      throw Exception(e);
    } finally {
      if (databaseProvider.database.isOpen) {
        databaseProvider.database.close();
      }
    }
  }

  Future<OrdemServicoServico> findById(int id) async {
    var ordemServicoServico = OrdemServicoServico();
    try {
      await databaseProvider.open();
      Database dt = databaseProvider.database;
      List<Map<String, Object?>> result = await dt.rawQuery("SELECT * FROM OrdemServicoServico WHERE id = ?", [id]);
      
      if (result.isNotEmpty) {
        Map<String, Object?> item = result[0];
        ordemServicoServico = OrdemServicoServico.fromMap(item);
      }
    } on Exception catch (e) {
      throw Exception(e);
    } finally {
      if (databaseProvider.database.isOpen) {
        databaseProvider.database.close();
      }
    }
    return ordemServicoServico;
  }

  Future<List<OrdemServicoServico>> findAll() async {
    await databaseProvider.open();
    Database dt = databaseProvider.database;
    List<Map<String, Object?>> result = await dt.rawQuery("SELECT * FROM OrdemServicoServico");

    List<OrdemServicoServico> ordemServicoServicoResults = [];
    if (result.isNotEmpty) {
      for (var item in result) {
        OrdemServicoServico ordemServicoServico = OrdemServicoServico.fromMap(item);
        ordemServicoServicoResults.add(ordemServicoServico);
      }
    }
    return ordemServicoServicoResults;
  }
}
