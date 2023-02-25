import 'package:chatapp/screens/dashboard.dart';
import 'package:chatapp/screens/signup_screen.dart';
import 'package:chatapp/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:chatapp/constants.dart';

import 'login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: bgColor),
      home: Scaffold(
        body: Column(
          children: <Widget>[
            Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        child: OrientationBuilder(
                          builder: (context, orientation) => Padding(
                            padding: EdgeInsets.all(30),
                            child: SvgPicture.asset("images/users.svg"),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10, left: 10),
                    child: Text(
                      "Doctors Appointment",
                      style: TextStyle(
                          color: secondaryColor,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                          wordSpacing: 2),
                    ),
                  ),
                  Text(
                    "Appoint Your Doctor",
                    style: TextStyle(
                      color: secondaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(25),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        minimumSize: const Size(340, 70),
                        foregroundColor: Colors.white,
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                      ),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Navbar()));
                      },
                      child: const Text('Get Started',
                          style: TextStyle(fontSize: 20)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
