import 'package:flutter_app_oficina_mecanica_template/data/database_provider.dart';
import 'package:flutter_app_oficina_mecanica_template/domain/models/tipo_pagamento_model.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class TipoPagamentoRepository {
  late DatabaseProvider databaseProvider;

  TipoPagamentoRepository(this.databaseProvider);

  Future<int> insert(TipoPagamento entity) async {
    try {
      await databaseProvider.open();
      Database dt = databaseProvider.database;
      return await dt.insert("TipoPagamento", entity.toMap());
    } on Exception catch (e) {
      throw Exception(e);
    } finally {
      if (databaseProvider.database.isOpen) {
        databaseProvider.database.close();
      }
    }
  }

  Future<int> delete(TipoPagamento entity) async {
    try {
      await databaseProvider.open();
      Database dt = databaseProvider.database;
      return await dt.delete("TipoPagamento", where: "id = ?", whereArgs: ["${entity.id}"]);
    } on Exception catch (e) {
      throw Exception(e);
    } finally {
      if (databaseProvider.database.isOpen) {
        databaseProvider.database.close();
      }
    }
  }

  Future<int> update(TipoPagamento entity) async {
    try {
      await databaseProvider.open();
      Database dt = databaseProvider.database;
      return await dt.update("TipoPagamento", entity.toMap(), where: "id = ?", whereArgs: ["${entity.id}"]);
    } on Exception catch (e) {
      throw Exception(e);
    } finally {
      if (databaseProvider.database.isOpen) {
        databaseProvider.database.close();
      }
    }
  }

  Future<TipoPagamento> findById(int id) async {
    var tipoPagamento = TipoPagamento();
    try {
      await databaseProvider.open();
      Database dt = databaseProvider.database;
      List<Map<String, Object?>> result = await dt.rawQuery("SELECT * FROM TipoPagamento WHERE id = ?", [id]);
      
      if (result.isNotEmpty) {
        Map<String, Object?> item = result[0];
        tipoPagamento = TipoPagamento.fromMap(item);
      }
    } on Exception catch (e) {
      throw Exception(e);
    } finally {
      if (databaseProvider.database.isOpen) {
        databaseProvider.database.close();
      }
    }
    return tipoPagamento;
  }

  Future<List<TipoPagamento>> findAll() async {
    await databaseProvider.open();
    Database dt = databaseProvider.database;
    List<Map<String, Object?>> result = await dt.rawQuery("SELECT * FROM TipoPagamento");

    List<TipoPagamento> tipoPagamentoResults = [];
    if (result.isNotEmpty) {
      for (var item in result) {
        TipoPagamento tipoPagamento = TipoPagamento.fromMap(item);
        tipoPagamentoResults.add(tipoPagamento);
      }
    }
    return tipoPagamentoResults;
  }
}
