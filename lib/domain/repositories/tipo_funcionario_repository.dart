import 'package:flutter_app_oficina_mecanica_template/data/database_provider.dart';
import 'package:flutter_app_oficina_mecanica_template/domain/models/tipo_funcionario_model.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class TipoFuncionarioRepository {
  late DatabaseProvider databaseProvider;

  TipoFuncionarioRepository(this.databaseProvider);

  Future<int> insert(TipoFuncionario entity) async {
    try {
      await databaseProvider.open();
      Database dt = databaseProvider.database;
      return await dt.insert("TipoFuncionario", entity.toMap());
    } on Exception catch (e) {
      throw Exception(e);
    } finally {
      if (databaseProvider.database.isOpen) {
        databaseProvider.database.close();
      }
    }
  }

  Future<int> delete(TipoFuncionario entity) async {
    try {
      await databaseProvider.open();
      Database dt = databaseProvider.database;
      return await dt.delete("TipoFuncionario", where: "id = ?", whereArgs: ["${entity.id}"]);
    } on Exception catch (e) {
      throw Exception(e);
    } finally {
      if (databaseProvider.database.isOpen) {
        databaseProvider.database.close();
      }
    }
  }

  Future<int> update(TipoFuncionario entity) async {
    try {
      await databaseProvider.open();
      Database dt = databaseProvider.database;
      return await dt.update("TipoFuncionario", entity.toMap(), where: "id = ?", whereArgs: ["${entity.id}"]);
    } on Exception catch (e) {
      throw Exception(e);
    } finally {
      if (databaseProvider.database.isOpen) {
        databaseProvider.database.close();
      }
    }
  }

  Future<TipoFuncionario> findById(int id) async {
    var tipoFuncionario = TipoFuncionario();
    try {
      await databaseProvider.open();
      Database dt = databaseProvider.database;
      List<Map<String, Object?>> result = await dt.rawQuery("SELECT * FROM TipoFuncionario WHERE id = ?", [id]);
      
      if (result.isNotEmpty) {
        Map<String, Object?> item = result[0];
        tipoFuncionario = TipoFuncionario.fromMap(item);
      }
    } on Exception catch (e) {
      throw Exception(e);
    } finally {
      if (databaseProvider.database.isOpen) {
        databaseProvider.database.close();
      }
    }
    return tipoFuncionario;
  }

  Future<List<TipoFuncionario>> findAll() async {
    await databaseProvider.open();
    Database dt = databaseProvider.database;
    List<Map<String, Object?>> result = await dt.rawQuery("SELECT * FROM TipoFuncionario");

    List<TipoFuncionario> tipoFuncionarioResults = [];
    if (result.isNotEmpty) {
      for (var item in result) {
        TipoFuncionario tipoFuncionario = TipoFuncionario.fromMap(item);
        tipoFuncionarioResults.add(tipoFuncionario);
      }
    }
    return tipoFuncionarioResults;
  }
}
