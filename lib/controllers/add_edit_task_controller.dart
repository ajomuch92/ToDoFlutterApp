import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:todoapp/models/task.dart';

class AddEditTaskController extends GetxController {
  final formKey = GlobalKey<FormBuilderState>();
  RxBool isEdit = false.obs;
  Task task = Task(title: '', description: '', isComplete: false);

  @override
  void onInit() {
    super.onInit();
    if(Get.arguments != null) {
      task = Get.arguments['task'] as Task;
      isEdit.value = true;
    }
  }
}