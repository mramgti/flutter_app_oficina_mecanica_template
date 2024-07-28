import 'package:flutter_app_oficina_mecanica_template/data/database_provider.dart';
import 'package:flutter_app_oficina_mecanica_template/domain/models/fornecedor_estoque_pecas_model.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class FornecedorEstoquePecasRepository {
  late DatabaseProvider databaseProvider;

  FornecedorEstoquePecasRepository(this.databaseProvider);

  Future<int> insert(FornecedorEstoquePecas entity) async {
    try {
      await databaseProvider.open();
      Database dt = databaseProvider.database;
      return await dt.insert("FornecedorEstoquePecas", entity.toMap());
    } on Exception catch (e) {
      throw Exception(e);
    } finally {
      if (databaseProvider.database.isOpen) {
        databaseProvider.database.close();
      }
    }
  }

  Future<int> delete(FornecedorEstoquePecas entity) async {
    try {
      await databaseProvider.open();
      Database dt = databaseProvider.database;
      return await dt.delete("FornecedorEstoquePecas", where: "id = ?", whereArgs: ["${entity.id}"]);
    } on Exception catch (e) {
      throw Exception(e);
    } finally {
      if (databaseProvider.database.isOpen) {
        databaseProvider.database.close();
      }
    }
  }

  Future<int> update(FornecedorEstoquePecas entity) async {
    try {
      await databaseProvider.open();
      Database dt = databaseProvider.database;
      return await dt.update("FornecedorEstoquePecas", entity.toMap(), where: "id = ?", whereArgs: ["${entity.id}"]);
    } on Exception catch (e) {
      throw Exception(e);
    } finally {
      if (databaseProvider.database.isOpen) {
        databaseProvider.database.close();
      }
    }
  }

  Future<FornecedorEstoquePecas> findById(int id) async {
    var fornecedorEstoquePecas = FornecedorEstoquePecas();
    try {
      await databaseProvider.open();
      Database dt = databaseProvider.database;
      List<Map<String, Object?>> result = await dt.rawQuery("SELECT * FROM FornecedorEstoquePecas WHERE id = ?", [id]);
      
      if (result.isNotEmpty) {
        Map<String, Object?> item = result[0];
        fornecedorEstoquePecas = FornecedorEstoquePecas.fromMap(item);
      }
    } on Exception catch (e) {
      throw Exception(e);
    } finally {
      if (databaseProvider.database.isOpen) {
        databaseProvider.database.close();
      }
    }
    return fornecedorEstoquePecas;
  }

  Future<List<FornecedorEstoquePecas>> findAll() async {
    await databaseProvider.open();
    Database dt = databaseProvider.database;
    List<Map<String, Object?>> result = await dt.rawQuery("SELECT * FROM FornecedorEstoquePecas");

    List<FornecedorEstoquePecas> fornecedorEstoquePecasResults = [];
    if (result.isNotEmpty) {
      for (var item in result) {
        FornecedorEstoquePecas fornecedorEstoquePecas = FornecedorEstoquePecas.fromMap(item);
        fornecedorEstoquePecasResults.add(fornecedorEstoquePecas);
      }
    }
    return fornecedorEstoquePecasResults;
  }
}
