import 'package:moor_flutter/moor_flutter.dart';
import 'package:taskmanagementapp/database/models/task.dart';
import 'dao/task_dao.dart';
import 'dao/user_dao.dart';
import 'models/user.dart';
part 'database.g.dart';


@UseMoor(tables: [Users,Tasks],daos: [UserDao,TaskDao])
class TaskManagerDatabase extends _$TaskManagerDatabase {
  TaskManagerDatabase():super(FlutterQueryExecutor.inDatabaseFolder(path: 'taskmanager.db',logStatements: true) );

  @override
  // TODO: implement schemaVersion
  int get schemaVersion => 1;

}