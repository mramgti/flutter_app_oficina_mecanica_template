import 'package:flutter_app_oficina_mecanica_template/data/database_provider.dart';
import 'package:flutter_app_oficina_mecanica_template/domain/models/entity.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class RepositorySQLite{

  late DatabaseProvider databaseProvider;

  RepositorySQLite(this.databaseProvider);

  Future<int> insert(Entity entity) async{
    try{
      
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

  Future<int>  delete(Entity entity) async{
    try{
      await databaseProvider.open();
      Database dt = databaseProvider.database;
      return await dt.delete(entity.tableName, 
                    where : "${entity.primarykey} = ?", 
                    whereArgs:  ["${entity.id}"]);
    } on Exception catch (e) {
        throw Exception(e);
      } finally {
        if (databaseProvider.database.isOpen) {
          databaseProvider.database.close();
        }
      }                   
  }

  Future<int>  update(Entity entity) async{
    try{
      await databaseProvider.open();
      Database dt = databaseProvider.database;
      return await dt.update(entity.tableName,
                      entity.toMap(), 
                      where : "${entity.primarykey} = ?", 
                    whereArgs:  ["${entity.id}"]);
    } on Exception catch (e) {
        throw Exception(e);
      } finally {
        if (databaseProvider.database.isOpen) {
          databaseProvider.database.close();
        }
      }                     
  }

  Future<Entity> findById(Entity entity) async{
    late Entity entityResult;
    try{
      
      await databaseProvider.open();
    Database dt = databaseProvider.database;
    List<Map<String, Object?>> result = await dt.query(entity.tableName, where : " id = ?",
                                  whereArgs : [entity.id]);     

    
     if (result.isNotEmpty){
        Map<String, Object?> item = result[0];
        entityResult = entity.fromMap(item);
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

  /// Busca todos os registro do banco de dados convertido para
  /// um objeto do tipo List<Estado>.   
  Future<List<Entity>> findAll(Entity entity) async{
    await databaseProvider.open();
    Database dt = databaseProvider.database;
    List<Map<String, Object?>> result = await dt.query(entity.tableName);
        
    List<Entity> entityResults = [];
    
    //Se retornou resultados
    if (result.isNotEmpty){
        for (int i = 0; i < result.length; i++){            
            Map<String, Object?> item = result[i];
            //Convertendo um Map para o objeto apropriado
            Entity entityResult = entity.fromMap(item);
            entityResults.add(entityResult);
        }
    }
     
    return entityResults;
  }  


}