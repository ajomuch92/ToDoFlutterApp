import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/button/gf_icon_button.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:simple_search_bar/simple_search_bar.dart';
import 'package:todoapp/controllers/home_controller.dart';
import 'package:todoapp/models/task.dart';
import 'package:todoapp/theme/theme.dart';
import 'package:todoapp/widgets/task_tile.dart';

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (_){
        return Scaffold(
          appBar: SearchAppBar(
            primary: Theme.of(context).primaryColor,
            appBarController: _.appBarController,
            searchHint: "Search...",
            mainTextColor: Colors.white,
            onChange: (String value) {
              //Your function to filter list. It should interact with
              //the Stream that generate the final list
            },
            mainAppBar: AppBar(
              title: Text('To Do App'),
              centerTitle: true,
              backgroundColor: mainColor,
              actions: <Widget>[
                InkWell(
                  child: Icon(FeatherIcons.search),
                  onTap: () {
                    _.appBarController.stream.add(true);
                  },
                ),
                GFIconButton(                          
                  onPressed: _.logout,             
                  icon: Icon(FeatherIcons.logOut, color: Colors.white,),
                  color: Colors.transparent,
                )
              ],
            ),
          ),
          body: Container(
            child: Column(
              children: [
                Text('Welcome ${_.currentUser.name}', style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold), maxLines: 3,),
                SizedBox(height: 10.0,),
                Expanded(
                  child: PagedListView<int, Task>(
                    pagingController: _.pagingController, 
                    builderDelegate: PagedChildBuilderDelegate<Task>(
                      itemBuilder: (context, item, index) => TaskTile(
                        task: item, 
                        onTap: (){
                          _.showDetails(item);
                        },
                        onDeleteTap: (){
                          _.deleteTask();
                        },
                        onEditTap: (){
                          _.editTaks(item);
                        },
                      ),
                    )
                  ),
                )
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: mainColor,
            child: Icon(FeatherIcons.plus),
            onPressed: _.newTask,
          ),
        );
      },
    );
  }
}