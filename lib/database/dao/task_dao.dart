import 'package:moor_flutter/moor_flutter.dart';
import 'package:taskmanagementapp/database/models/task.dart';

import '../database.dart';
part 'task_dao.g.dart';


@UseDao(tables: [Tasks])
class TaskDao extends DatabaseAccessor<TaskManagerDatabase> with _$TaskDaoMixin
{
  TaskDao(TaskManagerDatabase db):super(db);

  Future<int> insertTask(Task t){
    return into(tasks).insert(t);
  }

  Future<List<Task>> getTask(){
    return select(tasks).get();
  }

  Future<int> getTaskCount() async{
    var tk = await select(tasks).get();
    return tk.length;
  }

  Future deleteTask (Task task) => delete(tasks).delete(task);

  Future<List<Task>> getCompletedTask(){
    return (select(tasks)..where((tbl) => tbl.taskStatus.equals(true))).get();
  }

  Future<List<Task>> getNotCompletedTask(){
    return (select(tasks)..where((tbl) => tbl.taskStatus.equals(false))).get();
  }

  Future<bool> updateTask (Task task) => update(tasks).replace(task);

  Future<List<Task>> getCalendarTask(){
    return (select(tasks)..where((tbl) => tbl.taskStatus.equals(false))).get();
  }

}