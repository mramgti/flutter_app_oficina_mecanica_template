import 'package:flutter_app_oficina_mecanica_template/data/database_provider.dart';
import 'package:flutter_app_oficina_mecanica_template/domain/models/ordem_servico_veiculos_model.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class OrdemServicoVeiculosRepository {
  late DatabaseProvider databaseProvider;

  OrdemServicoVeiculosRepository(this.databaseProvider);

  Future<int> insert(OrdemServicoVeiculos entity) async {
    try {
      await databaseProvider.open();
      Database dt = databaseProvider.database;
      return await dt.insert("OrdemServicoVeiculos", entity.toMap());
    } on Exception catch (e) {
      throw Exception(e);
    } finally {
      if (databaseProvider.database.isOpen) {
        databaseProvider.database.close();
      }
    }
  }

  Future<int> delete(OrdemServicoVeiculos entity) async {
    try {
      await databaseProvider.open();
      Database dt = databaseProvider.database;
      return await dt.delete("OrdemServicoVeiculos", where: "id = ?", whereArgs: ["${entity.id}"]);
    } on Exception catch (e) {
      throw Exception(e);
    } finally {
      if (databaseProvider.database.isOpen) {
        databaseProvider.database.close();
      }
    }
  }

  Future<int> update(OrdemServicoVeiculos entity) async {
    try {
      await databaseProvider.open();
      Database dt = databaseProvider.database;
      return await dt.update("OrdemServicoVeiculos", entity.toMap(), where: "id = ?", whereArgs: ["${entity.id}"]);
    } on Exception catch (e) {
      throw Exception(e);
    } finally {
      if (databaseProvider.database.isOpen) {
        databaseProvider.database.close();
      }
    }
  }

  Future<OrdemServicoVeiculos> findById(int id) async {
    var ordemServicoVeiculos = OrdemServicoVeiculos();
    try {
      await databaseProvider.open();
      Database dt = databaseProvider.database;
      List<Map<String, Object?>> result = await dt.rawQuery("SELECT * FROM OrdemServicoVeiculos WHERE id = ?", [id]);
      
      if (result.isNotEmpty) {
        Map<String, Object?> item = result[0];
        ordemServicoVeiculos = OrdemServicoVeiculos.fromMap(item);
      }
    } on Exception catch (e) {
      throw Exception(e);
    } finally {
      if (databaseProvider.database.isOpen) {
        databaseProvider.database.close();
      }
    }
    return ordemServicoVeiculos;
  }

  Future<List<OrdemServicoVeiculos>> findAll() async {
    await databaseProvider.open();
    Database dt = databaseProvider.database;
    List<Map<String, Object?>> result = await dt.rawQuery("SELECT * FROM OrdemServicoVeiculos");

    List<OrdemServicoVeiculos> ordemServicoVeiculosResults = [];
    if (result.isNotEmpty) {
      for (var item in result) {
        OrdemServicoVeiculos ordemServicoVeiculos = OrdemServicoVeiculos.fromMap(item);
        ordemServicoVeiculosResults.add(ordemServicoVeiculos);
      }
    }
    return ordemServicoVeiculosResults;
  }
}
