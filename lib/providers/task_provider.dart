import 'package:todoapp/models/task.dart';

class TaskProvider {
  Future<List<Task>> getTasks(String uid, int page, int size) async{
    List<Task> tasks = [];
    tasks.add(Task(title: 'Test', description: 'This is a test', isComplete: false));
    tasks.add(Task(title: 'Test 2', description: 'This is a test 2', isComplete: true));
    await Future.delayed(Duration(milliseconds: 800));
    return tasks;
  }
}