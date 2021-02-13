import 'package:ars_progress_dialog/ars_progress_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:todoapp/models/task.dart';
import 'package:todoapp/theme/theme.dart';

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

ArsProgressDialog  getLoadingDialog({BuildContext context, String text}) {
  ArsProgressDialog  pr = ArsProgressDialog (
    context,
    blur: 2,
    backgroundColor: Color(0x33000000),
    loadingWidget: SizedBox(
      height: 120.0,
      width: 120.0,
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GFLoader(
              type: GFLoaderType.android,
              size: 70.0,
            ),
            Text(text)
          ],
        ),
      ),
    )
  );
  return pr;
}

void showToast(String title, String message, ToastType type) {
  Color _backgroundColor;
  Icon _icon;
  switch (type) {
    case ToastType.Error:
      _backgroundColor = redColor;
      _icon = Icon(FeatherIcons.xOctagon, color: Colors.white,);
    break;
    case ToastType.Warning:
      _backgroundColor = yellowColor;
      _icon = Icon(FeatherIcons.alertTriangle, color: Colors.white,);
    break;
    case ToastType.Success:
      _backgroundColor = greenColor;
      _icon = Icon(FeatherIcons.check, color: Colors.white,);
    break;
    default:
      _backgroundColor = mainColor;
      _icon = Icon(FeatherIcons.info, color: Colors.white,);
    break;
  }
  Get.snackbar(title, message,
    colorText: Colors.white,
    backgroundColor: _backgroundColor,
    // borderColor: _backgroundColor,
    snackPosition: SnackPosition.BOTTOM,
    icon: _icon
  );
}

enum ToastType {
  Error,
  Info,
  Success,
  Warning
}