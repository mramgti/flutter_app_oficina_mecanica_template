import 'package:flutter_app_oficina_mecanica_template/data/database_provider.dart';
import 'package:flutter_app_oficina_mecanica_template/domain/models/entity.dart';
import 'package:flutter_app_oficina_mecanica_template/domain/models/veiculos_model.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class RepositorySQLite<T extends Entity> {

  late DatabaseProvider databaseProvider;

  RepositorySQLite(this.databaseProvider);

  Future<int> insert(T entity) async {
    try {
      await databaseProvider.open();
      Database dt = databaseProvider.database;
      return await dt.insert(entity.tableName, entity.toMap());
    } on Exception catch (e) {
      throw Exception(e);
    } finally {
      if (databaseProvider.database.isOpen) {
        databaseProvider.database.close();
      }
    }
  }

  Future<int> delete(T entity) async {
    try {
      await databaseProvider.open();
      Database dt = databaseProvider.database;
      return await dt.delete(entity.tableName, 
                    where: "${entity.primarykey} = ?", 
                    whereArgs: ["${entity.getValueId}"]);
    } on Exception catch (e) {
      throw Exception(e);
    } finally {
      if (databaseProvider.database.isOpen) {
        databaseProvider.database.close();
      }
    }                   
  }

  Future<int> update(T entity) async {
    try {
      await databaseProvider.open();
      Database dt = databaseProvider.database;
      return await dt.update(entity.tableName,
                      entity.toMap(), 
                      where: "${entity.primarykey} = ?", 
                    whereArgs: ["${entity.getValueId}"]);
    } on Exception catch (e) {
      throw Exception(e);
    } finally {
      if (databaseProvider.database.isOpen) {
        databaseProvider.database.close();
      }
    }                     
  }

  Future<T> findById(T entity) async {
    late T entityResult;
    try {
      await databaseProvider.open();
      Database dt = databaseProvider.database;
      List<Map<String, Object?>> result = await dt.query(entity.tableName, 
                    where: "${entity.primarykey} = ?",
                    whereArgs: [entity.getValueId]);     

      if (result.isNotEmpty) {
        Map<String, Object?> item = result[0];
        entityResult = entity.fromMap(item) as T;
      }
    } on Exception catch (e) {
      throw Exception(e);
    } finally {
      if (databaseProvider.database.isOpen) {
        databaseProvider.database.close();
      }
    }

    return entityResult;
  }

  Future<List<T>> findAll(T entity) async {
    await databaseProvider.open();
    Database dt = databaseProvider.database;
    List<Map<String, Object?>> result = await dt.query(entity.tableName);
        
    List<T> entityResults = [];
    
    if (result.isNotEmpty) {
      for (int i = 0; i < result.length; i++) {            
        Map<String, Object?> item = result[i];
        T entityResult = entity.fromMap(item) as T;
        entityResults.add(entityResult);
      }
    }
     
    return entityResults;
  }

Future<List<Veiculos>> findVeiculosByClienteId(int idCliente) async {
  await databaseProvider.open();
  Database dt = databaseProvider.database;
  List<Map<String, Object?>> result = await dt.query(
    'veiculos',
    where: 'idCliente = ?',
    whereArgs: [idCliente],
  );

  List<Veiculos> entityResults = [];

  if (result.isNotEmpty) {
    for (int i = 0; i < result.length; i++) {
      Map<String, Object?> item = result[i];
      Veiculos entityResult = Veiculos.fromMap(item);
      entityResults.add(entityResult);
    }
  }

  return entityResults;
}
}
