import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskmanagementapp/database/database.dart';
import 'package:taskmanagementapp/screens/add_task_screen.dart';
import 'package:taskmanagementapp/screens/calendar_screen.dart';
import 'package:taskmanagementapp/screens/complete_tasks_screen.dart';
import 'package:taskmanagementapp/screens/home_screen.dart';
import 'package:taskmanagementapp/screens/not_complete_tasks_screen.dart';
import 'package:taskmanagementapp/screens/registration_screen.dart';
import 'package:taskmanagementapp/screens/update_task_screen.dart';

import 'screens/login_screen.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const TaskManagementApp());
}

class TaskManagementApp extends StatelessWidget {
  const TaskManagementApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      child: MaterialApp(
        title: 'One-Click Task Manager',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => SplashScreen(),
          'login': (context) => LoginScreen(),
          'registration': (context) => RegistrationScreen(),
          'home': (context) => HomeScreen(),
          'add': (context) => AddTaskScreen(),
          'update': (context) => UpdateTaskScreen(task: null),
          'complete': (context) => CompleteTasksScreen(),
          'notcomplete': (context) => NotCompleteTasksScreen(),
          'calendar': (context) => CalendarScreen(),
        },
      ),
      providers: [
        Provider(create: (_) => TaskManagerDatabase()),

      ],
    );
  }
}
