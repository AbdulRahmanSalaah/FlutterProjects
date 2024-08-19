import 'package:get/get.dart';

import '../db/db_helper.dart';
import '../models/task.dart';

class TaskController {
  final RxList<Task> taskList = <Task>[].obs;

  Future<int> addTask({Task? task}) {
    return DBHelper.insert(task);
  }

  getTasks() async {
    // get data from table
    final List<Map<String, dynamic>> tasks = await DBHelper.query();
 
    // assign data to taskList variable   
    taskList.assignAll(tasks.map((data) => Task.fromJson(data)).toList());
  }

  // delete data from table
  void deleteTasks(Task task) async {
    await DBHelper.delete(task);
    getTasks();
  }

  void deleteAllTasks() async {
    await DBHelper.deleteAll();
    getTasks();
  }

  // update data int table
  void markTaskCompleted(int id) async {
    await DBHelper.update(id);
    getTasks();
  }
}
