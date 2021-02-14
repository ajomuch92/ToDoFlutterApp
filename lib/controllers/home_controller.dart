import 'package:ars_progress_dialog/ars_progress_dialog.dart';
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

class HomeController extends GetxController {
  final AppBarController appBarController = AppBarController();
  final TaskProvider _taskProvider = TaskProvider();
  final PagingController<int, Task> pagingController = PagingController(firstPageKey: 0);
  final int _pageSize = 10;
  UserProvider _userProvider = UserProvider();
  GlobalController _globalController = Get.find();
  List<Task> _originalList = [];
  User currentUser;
  dynamic lastTask;

  @override
  void onInit() {
    super.onInit();
    currentUser = _globalController.getUser();
    pagingController.addPageRequestListener((pageKey) {
      print(pageKey);
      _loadPage(pageKey);
    });
  }
  
  @override
  void onClose() {
    print('on close');
    pagingController.dispose();
    super.onClose();
  }

  Future<void> _loadPage(int pageKey) async {
    try {
      ResponseResult result = await _taskProvider.getTasksV2(currentUser, pageKey, _pageSize, lastTask);
      if(result.code == 200) {
        List<Task> newItems = result.result['list'] as List<Task>;
        lastTask = result.result['last'];
        final isLastPage = newItems.length < _pageSize;
        _originalList.addAll(newItems);
        if (isLastPage) {
          pagingController.appendLastPage(newItems);
        } else {
          final nextPageKey = pageKey + newItems.length;
          pagingController.appendPage(newItems, nextPageKey);
        }
      } else {
        pagingController.error = result.message;
      }
    } catch (error) {
      pagingController.error = error;
    }
  }

  void logout() {
    showConfirmDialog('Logout', 'Are you sure you want to logout?', () async {
      ResponseResult result = await _userProvider.logout();
      if(result.code == 200) {
        Get.back();
        _globalController.deleteUser();
        Get.offAll(Index());
      }
      else
        showToast('Register', result.message, ToastType.Error);
    });
  }

  void deleteTask(Task task) {
    showConfirmDialog('Delete', 'Are you sure you want to delete this task?', () async{
      Get.back();
      ArsProgressDialog pr = getLoadingDialog(context: Get.overlayContext, text: 'Deleting...');
      pr.show();
      ResponseResult result = await _taskProvider.deleteTasksV2(task);
      pr.dismiss();
      if(result.code == 200) {
        _originalList.removeWhere((r) => r.id == task.id);
        pagingController.itemList = _originalList;
        update(['list']);
        showToast('Tasks', 'Task deleted successfully', ToastType.Success);
      } else {
        showToast('Delete', result.message, ToastType.Error);
      }
    });
  }

  void showDetails(Task task) {
    showTaskDetail(task);
  }

  void newTask() {
    Get.to(AddEditTaks()).then((value){
      if(value != null) {
        _originalList.add(value);
        pagingController.itemList = _originalList;
        update(['list']);
        showToast('Tasks', 'Task created successfully', ToastType.Success);
      }
    });
  }

  void editTaks(Task task) {
    Get.to(AddEditTaks(), arguments: {'task': task}).then((value){
      if(value != null) {
        Task _task = value as Task;
        int index = _originalList.indexWhere((r) => r.id == _task.id);
        if(index != -1) {
          _originalList[index] = _task;
          pagingController.itemList = _originalList;
          update(['list']);
        }
        showToast('Tasks', 'Task update successfully', ToastType.Success);
      }
    });
  }

  void searchChange(String value) {
    List<Task> _listTemp;
    if(!GetUtils.isNullOrBlank(value)) {
      value = value.toLowerCase();
      _listTemp = _originalList.where((element) => element.description.toLowerCase().contains(value) || element.title.toLowerCase().contains(value)).toList();
    } else {
      _listTemp = _originalList;
    }
    pagingController.itemList = _listTemp;
    update(['list']);
  }
}