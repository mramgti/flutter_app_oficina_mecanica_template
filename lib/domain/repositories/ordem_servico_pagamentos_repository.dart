import 'package:flutter_app_oficina_mecanica_template/data/database_provider.dart';
import 'package:flutter_app_oficina_mecanica_template/domain/models/ordem_servico_pagamentos_model.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class OrdemServicoPagamentosRepository {
  late DatabaseProvider databaseProvider;

  OrdemServicoPagamentosRepository(this.databaseProvider);

  Future<int> insert(OrdemServicoPagamentos entity) async {
    try {
      await databaseProvider.open();
      Database dt = databaseProvider.database;
      return await dt.insert("OrdemServicoPagamentos", entity.toMap());
    } on Exception catch (e) {
      throw Exception(e);
    } finally {
      if (databaseProvider.database.isOpen) {
        databaseProvider.database.close();
      }
    }
  }

  Future<int> delete(OrdemServicoPagamentos entity) async {
    try {
      await databaseProvider.open();
      Database dt = databaseProvider.database;
      return await dt.delete("OrdemServicoPagamentos", where: "id = ?", whereArgs: ["${entity.id}"]);
    } on Exception catch (e) {
      throw Exception(e);
    } finally {
      if (databaseProvider.database.isOpen) {
        databaseProvider.database.close();
      }
    }
  }

  Future<int> update(OrdemServicoPagamentos entity) async {
    try {
      await databaseProvider.open();
      Database dt = databaseProvider.database;
      return await dt.update("OrdemServicoPagamentos", entity.toMap(), where: "id = ?", whereArgs: ["${entity.id}"]);
    } on Exception catch (e) {
      throw Exception(e);
    } finally {
      if (databaseProvider.database.isOpen) {
        databaseProvider.database.close();
      }
    }
  }

  Future<OrdemServicoPagamentos> findById(int id) async {
    var ordemServicoPagamentos = OrdemServicoPagamentos();
    try {
      await databaseProvider.open();
      Database dt = databaseProvider.database;
      List<Map<String, Object?>> result = await dt.rawQuery("SELECT * FROM OrdemServicoPagamentos WHERE id = ?", [id]);
      
      if (result.isNotEmpty) {
        Map<String, Object?> item = result[0];
        ordemServicoPagamentos = OrdemServicoPagamentos.fromMap(item);
      }
    } on Exception catch (e) {
      throw Exception(e);
    } finally {
      if (databaseProvider.database.isOpen) {
        databaseProvider.database.close();
      }
    }
    return ordemServicoPagamentos;
  }

  Future<List<OrdemServicoPagamentos>> findAll() async {
    await databaseProvider.open();
    Database dt = databaseProvider.database;
    List<Map<String, Object?>> result = await dt.rawQuery("SELECT * FROM OrdemServicoPagamentos");

    List<OrdemServicoPagamentos> ordemServicoPagamentosResults = [];
    if (result.isNotEmpty) {
      for (var item in result) {
        OrdemServicoPagamentos ordemServicoPagamentos = OrdemServicoPagamentos.fromMap(item);
        ordemServicoPagamentosResults.add(ordemServicoPagamentos);
      }
    }
    return ordemServicoPagamentosResults;
  }
}
