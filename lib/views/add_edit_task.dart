import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:todoapp/controllers/add_edit_task_controller.dart';
import 'package:todoapp/theme/theme.dart';

class AddEditTaks extends StatelessWidget {
  const AddEditTaks({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddEditTaskController>(
      init: AddEditTaskController(),
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: Text(_.isEdit.value? 'Edit task': 'Add task'),
            centerTitle: true,
            backgroundColor: mainColor,
            leading: IconButton(
              onPressed: Get.back,
              icon: Icon(FeatherIcons.chevronLeft),
            ),
          ),
          body: Container(
            padding: EdgeInsets.all(18.0),
            child: FormBuilder(
              initialValue: _.task.toJson(),
              key: _.formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    FormBuilderTextField(
                      name: 'title',
                      decoration: InputDecoration(
                        hintText: 'Title',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context, errorText: 'This field is required'),
                      ]),
                      keyboardType: TextInputType.text
                    ),
                    SizedBox(height: 20,),
                    FormBuilderTextField(
                      name: 'description',
                      minLines: 2,
                      maxLines: 5,
                      decoration: InputDecoration(
                        hintText: 'Description',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context, errorText: 'This field is required'),
                      ]),
                      keyboardType: TextInputType.text
                    ),
                    FormBuilderCheckbox(
                      name: 'isComplete',
                      title: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Task complete?',
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: mainColor,
            child: Icon(FeatherIcons.save),
            onPressed: (){},
          )
        );
      },
    );
  }
}