import 'package:flutter_app_oficina_mecanica_template/data/database_provider.dart';
import 'package:flutter_app_oficina_mecanica_template/domain/models/ordem_servico_estoque_pecas_model.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class OrdemServicoEstoquePecasRepository {
  late DatabaseProvider databaseProvider;

  OrdemServicoEstoquePecasRepository(this.databaseProvider);

  Future<int> insert(OrdemServicoEstoquePecas entity) async {
    try {
      await databaseProvider.open();
      Database dt = databaseProvider.database;
      return await dt.insert("OrdemServicoEstoquePecas", entity.toMap());
    } on Exception catch (e) {
      throw Exception(e);
    } finally {
      if (databaseProvider.database.isOpen) {
        databaseProvider.database.close();
      }
    }
  }

  Future<int> delete(OrdemServicoEstoquePecas entity) async {
    try {
      await databaseProvider.open();
      Database dt = databaseProvider.database;
      return await dt.delete("OrdemServicoEstoquePecas", where: "id = ?", whereArgs: ["${entity.id}"]);
    } on Exception catch (e) {
      throw Exception(e);
    } finally {
      if (databaseProvider.database.isOpen) {
        databaseProvider.database.close();
      }
    }
  }

  Future<int> update(OrdemServicoEstoquePecas entity) async {
    try {
      await databaseProvider.open();
      Database dt = databaseProvider.database;
      return await dt.update("OrdemServicoEstoquePecas", entity.toMap(), where: "id = ?", whereArgs: ["${entity.id}"]);
    } on Exception catch (e) {
      throw Exception(e);
    } finally {
      if (databaseProvider.database.isOpen) {
        databaseProvider.database.close();
      }
    }
  }

  Future<OrdemServicoEstoquePecas> findById(int id) async {
    var ordemServicoEstoquePecas = OrdemServicoEstoquePecas();
    try {
      await databaseProvider.open();
      Database dt = databaseProvider.database;
      List<Map<String, Object?>> result = await dt.rawQuery("SELECT * FROM OrdemServicoEstoquePecas WHERE id = ?", [id]);
      
      if (result.isNotEmpty) {
        Map<String, Object?> item = result[0];
        ordemServicoEstoquePecas = OrdemServicoEstoquePecas.fromMap(item);
      }
    } on Exception catch (e) {
      throw Exception(e);
    } finally {
      if (databaseProvider.database.isOpen) {
        databaseProvider.database.close();
      }
    }
    return ordemServicoEstoquePecas;
  }

  Future<List<OrdemServicoEstoquePecas>> findAll() async {
    await databaseProvider.open();
    Database dt = databaseProvider.database;
    List<Map<String, Object?>> result = await dt.rawQuery("SELECT * FROM OrdemServicoEstoquePecas");

    List<OrdemServicoEstoquePecas> ordemServicoEstoquePecasResults = [];
    if (result.isNotEmpty) {
      for (var item in result) {
        OrdemServicoEstoquePecas ordemServicoEstoquePecas = OrdemServicoEstoquePecas.fromMap(item);
        ordemServicoEstoquePecasResults.add(ordemServicoEstoquePecas);
      }
    }
    return ordemServicoEstoquePecasResults;
  }
}