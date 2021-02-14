import 'package:ars_progress_dialog/ars_progress_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:todoapp/controllers/global_controller.dart';
import 'package:todoapp/models/response_result.dart';
import 'package:todoapp/models/task.dart';
import 'package:todoapp/models/user.dart';
import 'package:todoapp/providers/task_provider.dart';
import 'package:todoapp/utils/messages.dart';

class AddEditTaskController extends GetxController {
  final formKey = GlobalKey<FormBuilderState>();
  RxBool isEdit = false.obs;
  Task task = Task(title: '', description: '', isComplete: false, id: '');
  GlobalController _globalController = Get.find();
  final TaskProvider _taskProvider = TaskProvider();
  User _currentUser;

  @override
  void onInit() {
    super.onInit();
    _currentUser = _globalController.getUser();
    if(Get.arguments != null) {
      task = Get.arguments['task'] as Task;
      isEdit.value = true;
    }
  }

  saveHandler() {
    if(task.id == '') {
      _save();
    } else {
      _update();
    }
  }

  Future _save() async {
    if (formKey.currentState.saveAndValidate()) {
      dynamic values = formKey.currentState.value;
      Task _task = Task.fromNewOrEditableJson(values);
      _task.ownerUid = _currentUser.uuid;
      if(task.isComplete) {
        _task.finishedDate = DateTime.now();
      }
      ArsProgressDialog pr = getLoadingDialog(context: Get.overlayContext, text: 'Saving...');
      pr.show();
      ResponseResult result = await _taskProvider.addTasksV2(_task);
      pr.dismiss();
      if(result.code == 200) {
        Get.back(result: result.result);
      } else {
        showToast('Save', result.message, ToastType.Error);
      }
    }
  }
  
  Future _update() async {
    if (formKey.currentState.saveAndValidate()) {
      dynamic values = formKey.currentState.value;
      Task _task = Task.fromNewOrEditableJson(values);
      _task.id = task.id;
      _task.ownerUid = task.ownerUid;
      if(_task.isComplete) {
        _task.finishedDate = DateTime.now();
      }
      ArsProgressDialog pr = getLoadingDialog(context: Get.overlayContext, text: 'Saving...');
      pr.show();
      ResponseResult result = await _taskProvider.updateTasksV2(_task);
      pr.dismiss();
      if(result.code == 200) {
        Get.back(result: result.result);
      } else {
        showToast('Save', result.message, ToastType.Error);
      }
    }
  }
}