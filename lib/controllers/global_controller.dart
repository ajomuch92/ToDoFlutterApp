import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todoapp/models/user.dart';

class GlobalController extends GetxController {
  final GetStorage _storage = GetStorage('todo-app');

  void setUser(User user) {
    _storage.write('user', user.toCustomJson());
  }

  void deleteUser() {
    _storage.remove('user');
    _storage.erase();
  }

  User getUser() {
    dynamic possibleUser = _storage.read('user');
    User _user;
    if(possibleUser != null)
      _user = User.fromJson(possibleUser);
    return _user;
  }
}