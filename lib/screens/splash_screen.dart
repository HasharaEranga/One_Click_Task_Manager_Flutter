import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 10),(){
      Navigator.pushNamed(context, 'login');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image(
              image: AssetImage(
                'images/applogo.png',
              ),
              height: 100,
              width: 100,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Text(
                'One-Click Task Manager',
                textAlign: TextAlign.center,
                style: TextStyle(fontFamily: 'praise', fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
