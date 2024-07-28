import 'package:flutter_app_oficina_mecanica_template/data/database_provider.dart';
import 'package:flutter_app_oficina_mecanica_template/domain/models/tipo_status_model.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class TipoStatusRepository {
  late DatabaseProvider databaseProvider;

  TipoStatusRepository(this.databaseProvider);

  Future<int> insert(TipoStatus entity) async {
    try {
      await databaseProvider.open();
      Database dt = databaseProvider.database;
      return await dt.insert("TipoStatus", entity.toMap());
    } on Exception catch (e) {
      throw Exception(e);
    } finally {
      if (databaseProvider.database.isOpen) {
        databaseProvider.database.close();
      }
    }
  }

  Future<int> delete(TipoStatus entity) async {
    try {
      await databaseProvider.open();
      Database dt = databaseProvider.database;
      return await dt.delete("TipoStatus", where: "id = ?", whereArgs: ["${entity.id}"]);
    } on Exception catch (e) {
      throw Exception(e);
    } finally {
      if (databaseProvider.database.isOpen) {
        databaseProvider.database.close();
      }
    }
  }

  Future<int> update(TipoStatus entity) async {
    try {
      await databaseProvider.open();
      Database dt = databaseProvider.database;
      return await dt.update("TipoStatus", entity.toMap(), where: "id = ?", whereArgs: ["${entity.id}"]);
    } on Exception catch (e) {
      throw Exception(e);
    } finally {
      if (databaseProvider.database.isOpen) {
        databaseProvider.database.close();
      }
    }
  }

  Future<TipoStatus> findById(int id) async {
    var tipoStatus = TipoStatus();
    try {
      await databaseProvider.open();
      Database dt = databaseProvider.database;
      List<Map<String, Object?>> result = await dt.rawQuery("SELECT * FROM TipoStatus WHERE id = ?", [id]);
      
      if (result.isNotEmpty) {
        Map<String, Object?> item = result[0];
        tipoStatus = TipoStatus.fromMap(item);
      }
    } on Exception catch (e) {
      throw Exception(e);
    } finally {
      if (databaseProvider.database.isOpen) {
        databaseProvider.database.close();
      }
    }
    return tipoStatus;
  }

  Future<List<TipoStatus>> findAll() async {
    await databaseProvider.open();
    Database dt = databaseProvider.database;
    List<Map<String, Object?>> result = await dt.rawQuery("SELECT * FROM TipoStatus");

    List<TipoStatus> tipoStatusResults = [];
    if (result.isNotEmpty) {
      for (var item in result) {
        TipoStatus tipoStatus = TipoStatus.fromMap(item);
        tipoStatusResults.add(tipoStatus);
      }
    }
    return tipoStatusResults;
  }
}
