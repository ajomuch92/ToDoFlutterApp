import 'package:ars_progress_dialog/ars_progress_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:todoapp/controllers/global_controller.dart';
import 'package:todoapp/models/response_result.dart';
import 'package:todoapp/models/user.dart';
import 'package:todoapp/providers/user_provider.dart';
import 'package:todoapp/theme/theme.dart';
import 'package:todoapp/views/home.dart';
import 'package:todoapp/utils/messages.dart';

class IndexController extends GetxController {
  final formKey = GlobalKey<FormBuilderState>();
  final _registerFormKey = GlobalKey<FormBuilderState>();
  UserProvider _userProvider = UserProvider();
  RxBool _showPassword = false.obs;
  RxBool showPassword = false.obs;
  GlobalController _globalController = Get.find();

  void showModalRegister() {
    showMaterialModalBottomSheet(
        context: Get.overlayContext,
        isDismissible: true,
        bounce: true,
        builder: (context) {
          return Container(
            height: Get.height * 0.95,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.horizontal(
                left: Radius.circular(20), right: Radius.circular(20)
              )
            ),
            padding: EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: FormBuilder(
                key: _registerFormKey,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GFIconButton(
                          onPressed: Get.back,
                          type: GFButtonType.transparent,
                          icon: Icon(FeatherIcons.xCircle, color: redColor,),
                        ),
                      ],
                    ),
                    Text(
                      'Register',
                      style: TextStyle(
                          fontSize: 28.0, fontWeight: FontWeight.bold),
                    ),
                    Text('Please, fill the following fields'),
                    FormBuilderTextField(
                      name: 'name',
                      decoration: InputDecoration(
                        hintText: 'Name',
                        suffixIcon: Icon(FeatherIcons.user),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context,
                            errorText: 'This field is required'),
                      ]),
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    FormBuilderTextField(
                      name: 'email',
                      decoration: InputDecoration(
                        hintText: 'Email',
                        suffixIcon: Icon(FeatherIcons.mail),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context,
                            errorText: 'This field is required'),
                        FormBuilderValidators.email(context,
                            errorText: 'This is not a valid email')
                      ]),
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Obx(() => FormBuilderTextField(
                      name: 'password',
                      obscureText: !_showPassword.value,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        suffixIcon: IconButton(
                          icon: Icon(_showPassword.value
                              ? FeatherIcons.eyeOff
                              : FeatherIcons.eye),
                          onPressed: () {
                            _showPassword.value = !_showPassword.value;
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0)),
                        ),
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context,
                            errorText: 'This field is required'),
                        FormBuilderValidators.min(context, 5,
                            errorText:
                                'You must enter a password with at least 5 characters')
                      ]),
                      keyboardType: TextInputType.text,
                    )),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: Get.width * 0.5,
                      child: GFButton(
                        onPressed: register,
                        text: 'Register',
                        size: GFSize.LARGE,
                        shape: GFButtonShape.pills,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  void login() async {
    if (formKey.currentState.saveAndValidate()) {
      dynamic values = formKey.currentState.value;
      User user = User.fromJson(values);
      ArsProgressDialog pr = getLoadingDialog(context: Get.overlayContext, text: 'Sign In...');
      pr.show();
      ResponseResult result = await _userProvider.login(user);
      pr.dismiss();
      if(result.code == 200) {
        _globalController.setUser(result.result);
        Get.off(Home());
      } else {
        showToast('Login', result.message, ToastType.Error);
      }
    }
  }

  Future register() async {
    if (_registerFormKey.currentState.saveAndValidate()) {
      dynamic values = _registerFormKey.currentState.value;
      User user = User.fromJson(values);
      ArsProgressDialog pr = getLoadingDialog(context: Get.overlayContext, text: 'Saving...');
      pr.show();
      ResponseResult result = await _userProvider.register(user);
      pr.dismiss();
      if(result.code == 200) {
        Get.back();
        showToast('Register', 'User registered success', ToastType.Success);
      } else {
        showToast('Register', result.message, ToastType.Error);
      }
    }
  }
}
