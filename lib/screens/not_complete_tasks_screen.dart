import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:provider/provider.dart';
import 'package:taskmanagementapp/database/dao/task_dao.dart';
import 'package:taskmanagementapp/database/database.dart';
import 'package:taskmanagementapp/screens/update_task_screen.dart';

import 'add_task_screen.dart';
import 'calendar_screen.dart';
import 'complete_tasks_screen.dart';
import 'home_screen.dart';


class NotCompleteTasksScreen extends StatefulWidget {
  const NotCompleteTasksScreen({Key? key}) : super(key: key);

  @override
  _NotCompleteTasksScreenState createState() => _NotCompleteTasksScreenState();
}

class _NotCompleteTasksScreenState extends State<NotCompleteTasksScreen> {

  //ToDo: Creating Data Access Objects
  TaskDao? taskDao;
  TaskManagerDatabase? taskManagerDatabase;

  //ToDo: Creating Text Editing Controllers
  TextEditingController searchController = TextEditingController();

  String searchText = '';

  //ToDo: Creating Task List
  List<Task> notCompleteTaskList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    searchController.addListener(()
    {
      setState(() {
        searchText = searchController.text;
      });

    });
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    taskManagerDatabase = Provider.of<TaskManagerDatabase>(context);
    taskDao = taskManagerDatabase!.taskDao;
    loadAllNotCompleteTasks();

  }

  void loadAllNotCompleteTasks() async {
    notCompleteTaskList.clear();
    notCompleteTaskList.addAll(await taskDao!.getNotCompletedTask());
    setState(() {

    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      // ToDo: Drawer
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(image: AssetImage("images/task.jpg"),fit:BoxFit.cover)
              ),
              child: Text('Welcome One Click Task Manager..!!', style: TextStyle(fontFamily: 'roboto', fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),),
            ),

            ListTile(
              title: const Text('Completed Tasks',style: TextStyle(fontFamily: 'lato',fontWeight: FontWeight.bold, fontSize: 16,color: Colors.deepOrange),),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return CompleteTasksScreen();
                },),);

                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: const Text('Not Completetd Tasks',style: TextStyle(fontFamily: 'lato',fontWeight: FontWeight.bold, fontSize: 16,color: Colors.deepOrange),),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return NotCompleteTasksScreen();
                },),);

                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: const Text('Calendar', style: TextStyle(fontFamily: 'lato',fontWeight: FontWeight.bold, fontSize: 16,color: Colors.deepOrange),),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return CalendarScreen();
                },),);

                // Update the state of the app.
                // ...
              },
            ),
          ],
        ),
      ),
      // ToDo: AppBar
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        actions: [IconButton(icon: Icon(Icons.home), onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return HomeScreen();
          },
          ),);
        },
        ),
        ],

        iconTheme: IconThemeData(color: Colors.black87),
      ),
      // ToDo: Body of the UI
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Not Completed Tasks',
                      style: TextStyle(
                        fontFamily: 'roboto',
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text('${notCompleteTaskList.length} Not Completed Tasks',
                      style: TextStyle(
                        fontFamily: 'roboto',
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 10,
                    offset: Offset(1,2),
                  ),
                ],
              ),
              child: Column(
                  children: [
              Padding(
              padding: const EdgeInsets.only(top: 20,right: 20,left: 20),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: TextStyle(
                      fontSize: 15,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.bold),
                ),
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.bold),
              ),
            ),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (BuildContext context, int index){
                    return _item(index);
                  },
                  padding: EdgeInsets.all(30),
                  itemCount: notCompleteTaskList.length,
                  /*itemBuilder: (BuildContext context, int index){
                      Widget _item(int index) {
                        return SwipeActionCell(
                          key: ValueKey(taskList[index]),
                          trailingActions: [
                            SwipeAction(
                                nestedAction: SwipeNestedAction(
                                  ///customize your nested action content

                                  content: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: Colors.red,
                                    ),
                                    width: 130,
                                    height: 60,
                                    child: OverflowBox(
                                      maxWidth: double.infinity,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.delete,
                                            color: Colors.white,
                                          ),
                                          Text('Update',
                                              style: TextStyle(color: Colors.white, fontSize: 20)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),

                                ///you should set the default  bg color to transparent
                                color: Colors.transparent,

                                ///set content instead of title of icon
                                content: _getIconButton(Colors.red, Icons.delete),
                                onTap: (handler) async {
                                  list.removeAt(index);
                                  setState(() {});
                                }),
                            SwipeAction(
                                content: _getIconButton(Colors.grey, Icons.vertical_align_top),
                                color: Colors.transparent,
                                onTap: (handler) {}),
                          ],
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                                "This is index of ${list[index]},Awesome Swipe Action Cell!! I like it very much!",
                                style: TextStyle(fontSize: 25)),
                          ),
                        );
                      }

                      Widget _getIconButton(color, icon) {
                        return Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),

                            ///set you real bg color in your content
                            color: color,
                          ),
                          child: Icon(
                            icon,
                            color: Colors.white,
                          ),
                        );
                      }
                    },*/

                ),
              ),
            ],),
            ),
          ),
        ],
      ),
    );
  }

  Widget _item(int index) {
    return searchText.isEmpty ? Padding(
      padding: const EdgeInsets.all(8.0),
      child: SwipeActionCell(
        key: ObjectKey(notCompleteTaskList[index]),
        trailingActions: <SwipeAction>[
          SwipeAction(
              title: "Delete",
              onTap: (CompletionHandler handler) async {
                showCupertinoDialog(
                    context: context,
                    builder: (c) {
                      return CupertinoAlertDialog(
                        title: Text('Are You sure to Delete?'),
                        actions: <Widget>[
                          CupertinoDialogAction(
                            child: Text('Delete'),
                            isDestructiveAction: true,
                            onPressed: () async {
                              await taskDao!.deleteTask(notCompleteTaskList[index]);
                              Navigator.pop(context);
                              await handler(true);
                              notCompleteTaskList.removeAt(index);
                              loadAllNotCompleteTasks();
                            },
                          ),
                          CupertinoDialogAction(
                            child: Text('Cancel'),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      );
                    });
              },
              color: Colors.green),

        ],
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  notCompleteTaskList[index].taskName,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),

              ],
            ),
          ),
        ),
      ),
    ) : notCompleteTaskList[index].taskName.toLowerCase().contains(searchText.toLowerCase()) ? Padding(
      padding: const EdgeInsets.all(8.0),
      child: SwipeActionCell(
        key: ObjectKey(notCompleteTaskList[index]),
        trailingActions: <SwipeAction>[
          SwipeAction(
              title: "Delete",
              onTap: (CompletionHandler handler) async {
                showCupertinoDialog(
                    context: context,
                    builder: (c) {
                      return CupertinoAlertDialog(
                        title: Text('Are You sure to Delete?'),
                        actions: <Widget>[
                          CupertinoDialogAction(
                            child: Text('Delete'),
                            isDestructiveAction: true,
                            onPressed: () async {
                              await taskDao!.deleteTask(notCompleteTaskList[index]);
                              Navigator.pop(context);
                              await handler(true);
                              notCompleteTaskList.removeAt(index);
                              loadAllNotCompleteTasks();
                            },
                          ),
                          CupertinoDialogAction(
                            child: Text('Cancel'),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      );
                    });
              },
              color: Colors.green),
        ],
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  notCompleteTaskList[index].taskName,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),

              ],
            ),
          ),
        ),
      ),
    ): SizedBox.shrink();
  }

  Widget _getIconButton(color, icon) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),

        ///set you real bg color in your content
        color: color,
      ),
      child: Icon(
        icon,
        color: Colors.white,
      ),
    );
  }

}

