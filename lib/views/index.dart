import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:todoapp/controllers/index_controller.dart';

class Index extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GetBuilder<IndexController>(
      init: IndexController(),
      builder: (_) {
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Welcome',
                  style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold
                  ),
                ),
                Text(
                  'To Do App',
                  style: TextStyle(
                    fontSize: 24.0,
                  ),
                ),
                SizedBox(height: 20,),
                SizedBox(
                  height: Get.height * 0.15,
                  child: Image.asset('assets/images/to-do-list.png')
                ),
                SizedBox(height: 20,),
                Container(
                  padding: EdgeInsets.only(right: 18.0, left: 18.0),
                  child: FormBuilder(
                    key: _.formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
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
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                SizedBox(
                  width: Get.width * 0.5,
                  child: GFButton(
                    onPressed: _.login,
                    text: 'Log In',
                    shape: GFButtonShape.pills,
                    size: GFSize.LARGE,
                    icon: Icon(FeatherIcons.logIn, color: Colors.white,)
                  ),
                ),
                SizedBox(height: 10,),
                SizedBox(
                  width: Get.width * 0.5,
                  child: GFButton(
                    onPressed: _.showModalRegister,
                    text: 'Create an account',
                    size: GFSize.LARGE,
                    type: GFButtonType.transparent,
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}