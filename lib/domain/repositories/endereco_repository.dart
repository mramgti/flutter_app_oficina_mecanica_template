import 'package:flutter_app_oficina_mecanica_template/data/database_provider.dart';
import 'package:flutter_app_oficina_mecanica_template/domain/models/endereco_model.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class EnderecoRepository {
  late DatabaseProvider databaseProvider;

  EnderecoRepository(this.databaseProvider);

  Future<int> insert(Endereco entity) async {
    try {
      await databaseProvider.open();
      Database dt = databaseProvider.database;
      return await dt.insert("Endereco", entity.toMap());
    } on Exception catch (e) {
      throw Exception(e);
    } finally {
      if (databaseProvider.database.isOpen) {
        databaseProvider.database.close();
      }
    }
  }

  Future<int> delete(Endereco entity) async {
    try {
      await databaseProvider.open();
      Database dt = databaseProvider.database;
      return await dt.delete("Endereco", where: "id = ?", whereArgs: [entity.id]);
    } on Exception catch (e) {
      throw Exception(e);
    } finally {
      if (databaseProvider.database.isOpen) {
        databaseProvider.database.close();
      }
    }
  }

  Future<int> update(Endereco entity) async {
    try {
      await databaseProvider.open();
      Database dt = databaseProvider.database;
      return await dt.update("Endereco", entity.toMap(), where: "id = ?", whereArgs: [entity.id]);
    } on Exception catch (e) {
      throw Exception(e);
    } finally {
      if (databaseProvider.database.isOpen) {
        databaseProvider.database.close();
      }
    }
  }

  Future<Endereco> findById(int id) async {
    Endereco endereco = Endereco();
    try {
      await databaseProvider.open();
      Database dt = databaseProvider.database;
      List<Map<String, Object?>> result = await dt.rawQuery("SELECT * FROM Endereco WHERE id = ?", [id]);

      if (result.isNotEmpty) {
        Map<String, Object?> item = result[0];
        endereco = Endereco.fromMap(item);
      }
    } on Exception catch (e) {
      throw Exception(e);
    } finally {
      if (databaseProvider.database.isOpen) {
        databaseProvider.database.close();
      }
    }
    return endereco;
  }

  Future<List<Endereco>> findAll() async {
    await databaseProvider.open();
    Database dt = databaseProvider.database;
    List<Map<String, Object?>> result = await dt.rawQuery("SELECT * FROM Endereco");

    List<Endereco> enderecoResults = [];
    if (result.isNotEmpty) {
      for (var item in result) {
        Endereco endereco = Endereco.fromMap(item);
        enderecoResults.add(endereco);
      }
    }
    return enderecoResults;
  }
}
