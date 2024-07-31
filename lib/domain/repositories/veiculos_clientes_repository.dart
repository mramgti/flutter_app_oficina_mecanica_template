import 'package:flutter_app_oficina_mecanica_template/data/database_provider.dart';
import 'package:flutter_app_oficina_mecanica_template/domain/models/veiculos_clientes_model.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class VeiculosClientesRepository {
  late DatabaseProvider databaseProvider;

  VeiculosClientesRepository(this.databaseProvider);

  Future<int> insert(VeiculosClientes entity) async {
    try {
      await databaseProvider.open();
      Database dt = databaseProvider.database;
      return await dt.insert("VeiculosClientes", entity.toMap());
    } on Exception catch (e) {
      throw Exception(e);
    } finally {
      if (databaseProvider.database.isOpen) {
        databaseProvider.database.close();
      }
    }
  }

  Future<int> delete(VeiculosClientes entity) async {
    try {
      await databaseProvider.open();
      Database dt = databaseProvider.database;
      return await dt.delete("VeiculosClientes", where: "id = ?", whereArgs: ["${entity.id}"]);
    } on Exception catch (e) {
      throw Exception(e);
    } finally {
      if (databaseProvider.database.isOpen) {
        databaseProvider.database.close();
      }
    }
  }

  Future<int> update(VeiculosClientes entity) async {
    try {
      await databaseProvider.open();
      Database dt = databaseProvider.database;
      return await dt.update("VeiculosClientes", entity.toMap(), where: "id = ?", whereArgs: ["${entity.id}"]);
    } on Exception catch (e) {
      throw Exception(e);
    } finally {
      if (databaseProvider.database.isOpen) {
        databaseProvider.database.close();
      }
    }
  }

  Future<VeiculosClientes> findById(int id) async {
    var veiculoCliente = VeiculosClientes();
    try {
      await databaseProvider.open();
      Database dt = databaseProvider.database;
      List<Map<String, Object?>> result = await dt.rawQuery("SELECT * FROM VeiculosClientes WHERE id = ?", [id]);
      
      if (result.isNotEmpty) {
        Map<String, Object?> item = result[0];
        veiculoCliente = VeiculosClientes.fromMap(item);
      }
    } on Exception catch (e) {
      throw Exception(e);
    } finally {
      if (databaseProvider.database.isOpen) {
        databaseProvider.database.close();
      }
    }
    return veiculoCliente;
  }

  Future<List<VeiculosClientes>> findAll() async {
    await databaseProvider.open();
    Database dt = databaseProvider.database;
    List<Map<String, Object?>> result = await dt.rawQuery("SELECT * FROM VeiculosClientes");

    List<VeiculosClientes> veiculosClientesResults = [];
    if (result.isNotEmpty) {
      for (var item in result) {
        VeiculosClientes veiculoCliente = VeiculosClientes.fromMap(item);
        veiculosClientesResults.add(veiculoCliente);
      }
    }
    return veiculosClientesResults;
  }
}
