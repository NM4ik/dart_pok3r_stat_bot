import 'package:pok3r_bot/feature/data/models/user/user.dart';

abstract class IUserRepository {
  String userCollectionLink = 'user_collection';

  /* fetch all users from db */
  Future<List<User>> getAllUsers();

  /* get user by name from db */
  Future<User?> getSingleUser(String name);

  /* create user by name for db */
  Future<User?> createUser(String name);
}
