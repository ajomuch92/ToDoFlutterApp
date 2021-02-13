import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:todoapp/models/task.dart';

void showConfirmDialog(String title, String message, Function onYes) {
  Get.dialog(AlertDialog(
    title: Text(title),
    content: Text(message,
      style: TextStyle(fontSize: 16.0, color: Colors.black)
    ),
    actions: <Widget>[
      new FlatButton(
        child: new Text('Yes'),
        onPressed: onYes,
      ),
      new FlatButton(
        child: new Text('Cancel'),
        onPressed: () {
          Get.back();
        },
      ),
    ],
  ));
}

void showTaskDetail(Task task) {
  Get.dialog(AlertDialog(
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(task.isComplete? 'Task completed': 'Task to complete'),
        Icon(task.isComplete? FeatherIcons.checkCircle: FeatherIcons.clock)
      ],
    ),
    content: Text(task.description),
    actions: <Widget>[
      new FlatButton(
        child: new Text('Ok'),
        onPressed: () {
          Get.back();
        },
      ),
    ],
  ));
}