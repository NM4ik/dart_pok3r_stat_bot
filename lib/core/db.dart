import 'package:mongo_dart/mongo_dart.dart';
import 'package:pok3r_bot/core/config.dart';
import 'package:pok3r_bot/core/handler.dart';

class Database {
  static Db? _database;

  Future<bool> create() async {
    try {
      _database = Db(dbPath);
      await _database!.open();
      return true;
    } on Object catch (e) {
      Handler.catchError(exception: e, methodName: 'Database.create');
      return false;
    }
  }

  static Db get database => _database!;
}
