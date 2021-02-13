import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todoapp/views/home.dart';
import 'package:todoapp/views/index.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;

import 'controllers/global_controller.dart';
import 'models/user.dart';

Future main() async {
  await DotEnv.load(fileName: ".env");
  await Firebase.initializeApp();
  await GetStorage.init('todo-app');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final GlobalController _globalController = Get.put(GlobalController());
  
  @override
  Widget build(BuildContext context) {
    User user = _globalController.getUser();
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Montserrat',
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: user == null? Index(): Home(),
    );
  }
}

