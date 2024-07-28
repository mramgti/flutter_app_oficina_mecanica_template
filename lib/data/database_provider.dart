import 'dart:io';

import 'package:flutter_app_oficina_mecanica_template/data/config.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class DatabaseProvider {
  late Database _database;

  Database get database => _database;

  /// Abre a conexão com o banco
  Future<void> open() async {
    // Carrega as bibliotecas do SQLite
    sqfliteFfiInit();
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      // Se for Windows ou Linux altera a forma para a criação do banco
      databaseFactory = databaseFactoryFfi;
    }

    String path = join(await getDatabasesPath(), "appoficinatemplate.db");

    // Verifica se o banco de dados já existe
    bool databaseExists = await databaseFactory.databaseExists(path);

    if (!databaseExists) {
      // Se o banco de dados não existir, cria-o
      _database = await openDatabase(
        path,
        version: 1,
        onCreate: (db, version) => _create(db, version),
      );
    } else {
      // Se o banco de dados já existir, abre-o
      _database = await openDatabase(path);
    }
  }

  Future<void> _create(Database db, int version) async {
    return db.execute(Config.sql);
  }

  Future<void> close() async {
    await _database.close();
  }
}