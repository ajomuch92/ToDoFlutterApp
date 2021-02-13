import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:simple_search_bar/simple_search_bar.dart';
import 'package:todoapp/controllers/global_controller.dart';
import 'package:todoapp/models/response_result.dart';
import 'package:todoapp/models/task.dart';
import 'package:todoapp/models/user.dart';
import 'package:todoapp/providers/task_provider.dart';
import 'package:todoapp/providers/user_provider.dart';
import 'package:todoapp/utils/messages.dart';
import 'package:todoapp/views/add_edit_task.dart';
import 'package:todoapp/views/index.dart';
import 'package:todoapp/utils/messages.dart';

class HomeController extends GetxController {
  final AppBarController appBarController = AppBarController();
  final TaskProvider _taskProvider = TaskProvider();
  final PagingController<int, Task> pagingController = PagingController(firstPageKey: 0);
  final int _pageSize = 10;
  UserProvider _userProvider = UserProvider();
  GlobalController _globalController = Get.find();
  User currentUser;

  @override
  void onInit() {
    super.onInit();
    currentUser = _globalController.getUser();
    pagingController.addPageRequestListener((pageKey) {
      print(pageKey);
      _loadPage(pageKey);
    });
  }

  Future<void> _loadPage(int pageKey) async {
    try {
      print('Loading page');
      final newItems = await _taskProvider.getTasks('', pageKey, _pageSize);
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      pagingController.error = error;
    }
  }

  void logout() {
    showConfirmDialog('Logout', 'Are you sure you want to logout?', () async {
      ResponseResult result = await _userProvider.logout();
      if(result.code == 200) {
        _globalController.deleteUser();
        Get.off(Index());
      }
      else
        showToast('Register', result.message, ToastType.Error);
    });
  }

  void deleteTask() {
    showConfirmDialog('Delete', 'Are you sure you want to delete this task?', () {
      Get.back();
    });
  }

  void showDetails(Task task) {
    showTaskDetail(task);
  }

  void newTask() {
    Get.to(AddEditTaks());
  }

  void editTaks(Task task) {
    Get.to(AddEditTaks(), arguments: {'task': task});
  }
}