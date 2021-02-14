import 'package:dio/dio.dart';
import 'package:todoapp/models/response_result.dart';
import 'package:todoapp/models/task.dart';
import 'package:todoapp/models/user.dart';
import 'package:todoapp/providers/adapter.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';

class TaskProvider {
  Adapter _adapter = Adapter();
  Dio _http;
  ResponseResult _result = ResponseResult();

  CollectionReference _taskCollection = FirebaseFirestore.instance.collection('tasks');

  TaskProvider() {
    _http = _adapter.getAdapter();
  }

  Future<ResponseResult> getTasks(User user, int page, int size) async{
    // List<Task> tasks = [];
    // tasks.add(Task(title: 'Test', description: 'This is a test', isComplete: false));
    // tasks.add(Task(title: 'Test 2', description: 'This is a test 2', isComplete: true));
    // await Future.delayed(Duration(milliseconds: 800));
    // return tasks;
    try {
      Response response = await _http.get('/collections/Tasks/',
        options: Options(
            headers: {
              HttpHeaders.authorizationHeader: 'Bearer ${user.token}',
              HttpHeaders.contentTypeHeader: 'application/json'
            }
        ),
        // queryParameters: {
        //   'page': page,
        //   'limit': size,
        //   'where': [{
        //     'attribute': 'ownerUid',
        //     'operator': '=',
        //     'value': user.uuid
        //   }]
        // }
      );
      dynamic data = response.data;
      dynamic _data = data['data'];
      List<Task> list = [];
      for(Map i in _data) {
        list.add(Task.fromJson(i));
      }
      _result.code = 200;
      _result.result = list;
    } on DioError catch(error) {
      _result.code = error.response.statusCode;
      _result.message = 'There was an error during bringind the list, please try later.';
      _result.result = error.message;
    } catch(error) {
      _result.code = 500;
      _result.message = 'There was an error during bringind the list, please try later.';
    }
    return _result;
  }

  Future<ResponseResult> getTasksV2(User user, int page, int size) async{
    try {
      QuerySnapshot query = await _taskCollection
        // .where('ownerUid', isEqualTo: user.uuid)
        // .startAfter([page])
        // .limit(size)
        .get();
      List<Task> list = [];
      query.docs.forEach((doc) {
        dynamic data = doc.data();
        list.add(Task.fromJsonAndUid(data, doc.id));
      });
      _result.result = list;
      _result.code = 200;
    } catch(error) {
      _result.code = 500;
      _result.message = 'There was an error during bringind the list, please try later.';
    }
    return _result;
  }
  
  Future<ResponseResult> addTasksV2(Task task) async{
    try {
      DocumentReference doc = await _taskCollection.add(task.toJson());
      task.id = doc.id;
      _result.result = task;
      _result.code = 200;
      _result.message = 'Task created successfully';
    } catch(error) {
      _result.code = 500;
      _result.message = 'There was an error during task creation, please try later.';
    }
    return _result;
  }
  
  Future<ResponseResult> updateTasksV2(Task task) async{
    try {
      await _taskCollection.doc(task.id).update(task.toJson());
      _result.result = task;
      _result.code = 200;
      _result.message = 'Task updated successfully';
    } catch(error) {
      _result.code = 500;
      _result.message = 'There was an error during task updating, please try later.';
    }
    return _result;
  }
  
  Future<ResponseResult> deleteTasksV2(Task task) async{
    try {
      await _taskCollection.doc(task.id).delete();
      _result.result = task;
      _result.code = 200;
      _result.message = 'Task deleted successfully';
    } catch(error) {
      _result.code = 500;
      _result.message = 'There was an error during task deleting, please try later.';
    }
    return _result;
  }
}