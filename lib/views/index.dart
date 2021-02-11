import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todoapp/controllers/index_controller.dart';

class Index extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GetBuilder<IndexController>(
      init: IndexController(),
      builder: (_) {
        return Scaffold(
          body: Text('Welcome'),
        );
      }
    );
  }
}