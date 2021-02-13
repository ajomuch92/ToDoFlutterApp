import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class IndexController extends GetxController {
  final formKey = GlobalKey<FormBuilderState>();
  final _registerFormKey = GlobalKey<FormBuilderState>();

  void showModalRegister() {
    showMaterialModalBottomSheet(
      context: Get.overlayContext,
      isDismissible: true,
      bounce: true,
      builder: (context) {
        return Container(
          height: Get.height * 0.95,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.horizontal(left: Radius.circular(20), right: Radius.circular(20))
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
                        icon: Icon(FeatherIcons.xCircle),
                      ),
                    ],
                  ),
                  Text(
                    'Register',
                    style: TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Text('Please, fill the following fields'),
                  FormBuilderTextField(
                    name: 'name',
                    decoration: InputDecoration(
                      labelText: 'Name',
                      suffixIcon: Icon(FeatherIcons.user)
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(context, errorText: 'This field is required'),
                    ]),
                    keyboardType: TextInputType.text,
                  ),
                  FormBuilderTextField(
                    name: 'email',
                    decoration: InputDecoration(
                      labelText: 'Email',
                      suffixIcon: Icon(FeatherIcons.mail)
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(context, errorText: 'This field is required'),
                    ]),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  FormBuilderTextField(
                    name: 'password',
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      suffixIcon: Icon(FeatherIcons.eye)
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(context, errorText: 'This field is required'),
                    ]),
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(height: 10,),
                  SizedBox(
                    width: Get.width * 0.5,
                    child: GFButton(
                      onPressed: (){},
                      text: 'Register',
                      size: GFSize.LARGE,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      });
  }
}