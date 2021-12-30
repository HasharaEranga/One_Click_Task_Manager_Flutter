import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskmanagementapp/database/dao/user_dao.dart';
import 'package:taskmanagementapp/database/database.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  // ToDo: Creating Data Access Object
  UserDao? userDao;
  TaskManagerDatabase? taskManagerDatabase;

  // ToDo: Creating Text Editing Controllers
  TextEditingController usernameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    taskManagerDatabase = Provider.of<TaskManagerDatabase>(context);
    userDao = taskManagerDatabase!.userDao;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ToDo: AppBar
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text('One-Click Task Manager',
            style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontFamily: 'Lato',
                fontWeight: FontWeight.bold)),
        elevation: 0,
        automaticallyImplyLeading: false, // ToDo: Removing back icon
      ),
      // ToDo: Body of the UI
      body: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                'User Registration..!!',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              ),
              SizedBox(
                height: 30,
              ),
              TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  hintText: 'Enter UserName:',
                  hintStyle: TextStyle(fontFamily: 'Lato', color: Colors.black),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  hintText: 'Enter Email:',
                  hintStyle: TextStyle(fontFamily: 'Lato', color: Colors.black),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: mobileController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  hintText: 'Enter Mobile:',
                  hintStyle: TextStyle(fontFamily: 'Lato', color: Colors.black),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  hintText: 'Enter Password:',
                  hintStyle: TextStyle(fontFamily: 'Lato', color: Colors.black),
                ),
                obscureText: true,
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: confirmPasswordController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  hintText: 'Confirm Password:',
                  hintStyle: TextStyle(fontFamily: 'Lato', color: Colors.black),
                ),
                obscureText: true,
              ),
              SizedBox(
                height: 20,
              ),
              // ToDo: Registration Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 90),
                child: ElevatedButton(
                  onPressed: () async {
                    int usercount = await userDao!.getUserCount();
                    User user = User(
                        id: usercount + 1,
                        username: usernameController.text,
                        email: emailController.text,
                        mobile: mobileController.text,
                        password: passwordController.text);
                    int result = await userDao!.insertUser(user);
                    print(result);
                    if (result >= 0) {
                      Navigator.pushReplacementNamed(context, 'login');
                    }
                  },
                  child: Text('Register'),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.teal),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
