import 'package:mongo_dart/mongo_dart.dart';
import 'package:pok3r_bot/core/db.dart';
import 'package:uuid/uuid.dart';

import '../models/user/user.dart';

class UserService {
  final _db = Database.database;
  final userError = UserError();

  Future<User?> createUser(String name) async {
    final userCollection = _db.collection('user_collection');

    /// validate user name
    if (name.isEmpty || name.length < 5) {
      return throw userError.userWrongNameException;
    } else if (!(await userCollection.find(where.eq('name', name)).isEmpty)) {
      return throw userError.userAlreadyExists;
    }

    final uuid = Uuid();
    final user =
        User(uid: uuid.v1(), name: name, summaryBalance: 0, balanceHistory: []);

    final recordedResult =
        (await userCollection.insertOne(user.toJson())).document;

    if (recordedResult == null) {
      return null;
    }

    return User.fromJson(recordedResult);
  }
}

class UserError {
  Exception userWrongNameException =
      Exception('Неправильное имя. Имя должно быть длиннее.');
  Exception userAlreadyExists = Exception('Пользователь уже существует');
}
