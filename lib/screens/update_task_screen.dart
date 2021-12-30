import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskmanagementapp/database/dao/task_dao.dart';
import 'package:taskmanagementapp/database/database.dart';

import 'calendar_screen.dart';
import 'complete_tasks_screen.dart';
import 'home_screen.dart';
import 'not_complete_tasks_screen.dart';

class UpdateTaskScreen extends StatefulWidget {
  const UpdateTaskScreen({Key? key, required this.task}) : super(key: key);

  final Task? task;

  @override
  State<UpdateTaskScreen> createState() => _UpdateTaskScreenState();
}

class _UpdateTaskScreenState extends State<UpdateTaskScreen> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  DateTime selectedEndDate = DateTime.now();
  TimeOfDay selectedEndTime = TimeOfDay.now();

  //ToDo: Creating Data Access Objects
  TaskDao? taskDao;
  TaskManagerDatabase? taskManagerDatabase;

  //ToDo: Creating Text Editing Controllers
  TextEditingController taskNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    taskNameController.text = widget.task!.taskName;
    descriptionController.text = widget.task!.description;
    selectedDate = widget.task!.startDateTime;
    selectedTime = TimeOfDay.fromDateTime(selectedDate);
    selectedEndDate = widget.task!.endDateTime;
    selectedEndTime = TimeOfDay.fromDateTime(selectedEndDate);

  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    taskManagerDatabase = Provider.of<TaskManagerDatabase>(context);
    taskDao = taskManagerDatabase!.taskDao;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
              title: const Text('Completed Tasks',style: TextStyle(fontFamily: 'lato',fontWeight: FontWeight.bold, fontSize: 16, color: Colors.deepOrange),),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return CompleteTasksScreen();
                },),);

                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: const Text('Not Completed Tasks',style: TextStyle(fontFamily: 'lato',fontWeight: FontWeight.bold, fontSize: 16,color: Colors.deepOrange),),
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
        actions: [IconButton(icon: Icon(Icons.home),onPressed: (){
          Navigator.pop(context);

        },),],
        iconTheme: IconThemeData(color: Colors.black87),

      ),
      // ToDo: Body of the UI
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              child: Padding(
                padding: const EdgeInsets.only(top: 10,left: 40, bottom: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Update Tasks',
                      style: TextStyle(
                        fontFamily: 'roboto',
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text('You can update your Tasks from here..!!',
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
          SizedBox(
            height: 10,
          ),
          Expanded(
            flex: 3,
            child: Container(
              padding: EdgeInsets.only(top: 20),
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
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextField(
                      controller: taskNameController,
                      decoration: InputDecoration(
                        hintText: 'Enter Task Name:',
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: descriptionController,
                      decoration: InputDecoration(
                        hintText: 'Enter Description:',
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Start Date:',
                              style: TextStyle(color: Colors.black,fontFamily: 'roboto',fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            GestureDetector(
                              onTap: (){
                                _selectDate(context);
                              },
                              child: Text(
                                '${selectedDate.year}/${selectedDate.month}/${selectedDate.day}',
                                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15 ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Start Time:',
                              style: TextStyle(color: Colors.black,fontFamily: 'roboto',fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            GestureDetector(
                              onTap: (){
                                _selectTime(context);
                              },
                              child: Text(
                                '${selectedTime.hour}:${selectedTime.minute}',
                                style: TextStyle(fontFamily: 'roboto',fontWeight: FontWeight.bold),
                              ),

                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'End Date:',
                              style: TextStyle(color: Colors.black,fontFamily: 'roboto',fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            GestureDetector(
                              onTap: (){
                                _selecEndDate(context);
                              },
                              child: Text(
                                '${selectedEndDate.year}/${selectedEndDate.month}/${selectedEndDate.day}',
                                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15 ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'End Time:',
                              style: TextStyle(color: Colors.black,fontFamily: 'roboto',fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            GestureDetector(
                              onTap: (){
                                _selectEndTime(context);
                              },
                              child: Text(
                                '${selectedEndTime.hour}:${selectedEndTime.minute}',
                                style: TextStyle(fontFamily: 'roboto',fontWeight: FontWeight.bold),
                              ),

                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            ElevatedButton(onPressed: () async{

                              Task task = Task(id: widget.task!.id,taskName: taskNameController.text,description: descriptionController.text,startDateTime: DateTime(selectedDate.year,selectedDate.month,selectedDate.day,selectedTime.hour,selectedTime.minute),endDateTime: DateTime(selectedEndDate.year,selectedEndDate.month,selectedEndDate.day,selectedEndTime.hour,selectedEndTime.minute),taskStatus: false);
                              bool result = await taskDao!.updateTask(task);

                              if(result){
                                Navigator.pop(context, true);
                              }

                            },child: Text('Update'),style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.teal),),),
                          ],
                        ),
                        Column(
                          children: [
                            ElevatedButton(onPressed: () async{
                              Navigator.pop(context, false);

                            },child: Text('Cancel'),style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.teal),),),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //ToDo: Method for Pick the Date from the Calendar
  Future<void> _selectDate(BuildContext context) async{
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    setState(() {
      selectedDate = picked!;
    });
  }

  //ToDo: Method for Pick the Time from the Clock
  Future<void> _selectTime(BuildContext context) async{
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    setState(() {
      selectedTime = picked!;
    });
  }
  //ToDo: Method for Pick the Date from the Calendar
  Future<void> _selecEndDate(BuildContext context) async{
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    setState(() {
      selectedEndDate = picked!;
    });
  }

  //ToDo: Method for Pick the Time from the Clock
  Future<void> _selectEndTime(BuildContext context) async{
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    setState(() {
      selectedEndTime = picked!;
    });
  }

}
