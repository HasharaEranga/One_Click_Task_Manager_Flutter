import 'package:moor_flutter/moor_flutter.dart';
import 'package:taskmanagementapp/database/models/user.dart';

import '../database.dart';
part 'user_dao.g.dart';


@UseDao(tables: [Users])
class UserDao extends DatabaseAccessor<TaskManagerDatabase> with _$UserDaoMixin {
  UserDao(TaskManagerDatabase db) : super(db);

  Future<int> insertUser(User u){
    return into(users).insert(u);
  }

  Future<List<User>> getUser(String username){
    return (select(users)..where((tbl) => tbl.username.equals(username))).get();
  }

  Future<int> getUserCount() async {
    var use = await select(users).get();
    return use.length;
  }

}


