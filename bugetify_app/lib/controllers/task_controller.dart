import 'package:bugetify_app/db/db_helper.dart';
import 'package:bugetify_app/models/task.dart';
import 'package:get/get.dart';

class TaskController extends GetxController {
  //this will hold the data and update the ui

  @override
  void onReady() {
    getTasks();
    super.onReady();
  }

  final RxList<Task> taskList = List<Task>.empty().obs;

  // add data to table
  //second brackets means they are named optional parameters
  Future<void> addTask({required Task task}) async {
    await DBHelper.insert(task);
    DBHelper.addtoserver(task);
  }

  // get all the data from table
  void getTasks() async {
    List<Map<String, dynamic>> tasks = await DBHelper.query();
    taskList.assignAll(tasks.map((data) => new Task.fromJson(data)).toList());
  }

  // delete data from table
  void deleteTask(Task task) async {
    await DBHelper.delete(task);
    getTasks();
  }
}
