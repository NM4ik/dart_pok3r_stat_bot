import 'dart:developer';

import 'package:mongo_dart/mongo_dart.dart';
import 'package:pok3r_bot/core/config.dart';
import 'package:pok3r_bot/core/handler.dart';

class Database {
  static Db? _database;

  Future<void> create() async {
    try {
      _database = Db(dbPath);
      await _database?.open().then((value) => log('database connected'));
    } on Object catch (e) {
      Handler.catchError(exception: e, methodName: 'Database.create');
      throw Exception('dbExcep');
    }
  }

  static Db? get database => _database;
}
