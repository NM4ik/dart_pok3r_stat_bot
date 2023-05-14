import 'package:mongo_dart/mongo_dart.dart';
import 'package:pok3r_bot/core/db.dart';
import 'package:pok3r_bot/feature/domain/repositories/user.dart';

import '../models/user/user.dart';

class UserRepository extends IUserRepository {
  final _db = Database.database;
  // final userError = UserError();

  @override
  Future<User?> createUser(String name) async {
    final userCollection = _db?.collection('user_collection');

    if (userCollection == null) return null;

    /// validate user name
    if (name.isEmpty || name.length < 5) {
      return throw UserError().userWrongNameException;
    } else if (!(await userCollection.find(where.eq('name', name)).isEmpty)) {
      return throw UserError().userAlreadyExists;
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

  @override
  Future<List<User>> getAllUsers() {
    // TODO: implement getAllUsers
    throw UnimplementedError();
  }

  @override
  Future<User?> getSingleUser(String name) {
    // TODO: implement getSingleUser
    throw UnimplementedError();
  }

  // Future<User?> createUser(String name) async {

  // }
}

class UserError {
  Exception userWrongNameException =
      Exception('Неправильное имя. Имя должно быть длиннее.');
  Exception userAlreadyExists = Exception('Пользователь уже существует');
}
