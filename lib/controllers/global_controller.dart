import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todoapp/models/user.dart';

class GlobalController extends GetxController {
  final GetStorage _storage = GetStorage('todo-app');

  void setUser(User user) {
    _storage.write('user', user);
  }

  User getUser() {
    User _user = _storage.read<User>('user');
    return _user;
  }
}