import 'package:flutter/material.dart';

import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:taskmanagementapp/database/models/task.dart';

import 'complete_tasks_screen.dart';
import 'home_screen.dart';
import 'not_complete_tasks_screen.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
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
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return HomeScreen();
          },),);

        },),],
        iconTheme: IconThemeData(color: Colors.black87),

      ),
      // ToDo: Body of the UI
      body: Container(
        child: SfCalendar(
          view: CalendarView.month,
          dataSource: TaskDataSource(_getDataSource()),
          monthViewSettings: MonthViewSettings(
            appointmentDisplayMode: MonthAppointmentDisplayMode.appointment
          ),
          // ToDo: set Monday as the First Day of the Week
          firstDayOfWeek: 1,
          // ToDo: Set Initial Date Time
          initialSelectedDate: DateTime.now(),
          // ToDo: Set Selection Decoration
          selectionDecoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(color: Colors.red, width: 3),
            borderRadius: const BorderRadius.all(Radius.circular(4)),
            shape: BoxShape.rectangle,
          ),
          // ToDo: Set Today Highlight Color
          todayHighlightColor: Colors.deepPurpleAccent,
          // ToDo: Set Cell Border
          cellBorderColor: Colors.black,
          // ToDo: Show Navigation Arrow
          showNavigationArrow: true,
          cellEndPadding: 2,
          showCurrentTimeIndicator: true,
          // ToDo: Show Week Number
          showWeekNumber: true,
          weekNumberStyle: const WeekNumberStyle(
            backgroundColor: Colors.amber,
            textStyle: TextStyle(color: Colors.black, fontSize: 15),
          ),
        ),
      ),
    );
  }
}

List<Tasks> _getDataSource() {
  final List<Tasks> meetings = <Tasks>[];
  final DateTime today = DateTime.now();
  final DateTime startTime =
  DateTime(today.year, today.month, today.day, 9, 0, 0);
  final DateTime endTime = startTime.add(const Duration(hours: 2));
  //meetings.add(Meeting(
  //    'Conference', startTime, endTime, const Color(0xFF0F8644), false));
  meetings.add(Tasks());
  return meetings;
}


class TaskDataSource extends CalendarDataSource {
  TaskDataSource(List<Tasks> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }
}

class Meeting {
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}