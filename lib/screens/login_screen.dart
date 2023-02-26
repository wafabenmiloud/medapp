// ignore_for_file: prefer_const_constructors

import 'package:chatapp/screens/dashboard.dart';
import 'package:chatapp/services/authservice.dart';
import 'package:chatapp/widgets/navbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:chatapp/constants.dart';

import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool passToggle = true;
  var email, password, token;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      home: Scaffold(
        body: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Padding(
                  padding: EdgeInsets.all(80),
                  child: SvgPicture.asset('images/user.svg')),
            ),
            Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.only(right: 30, left: 30),
                          color: bgColor,
                          child: TextField(
                              decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.email,
                                    color: secondaryColor,
                                  ),
                                  hintText: "Email",
                                  hintStyle: TextStyle(color: secondaryColor),
                                  border: InputBorder.none),
                              onChanged: (value) {
                                email = value;
                              }),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.only(right: 30, left: 30),
                          color: bgColor,
                          child: TextField(
                            onChanged: (value) {
                              password = value;
                            },
                            obscureText: passToggle ? true : false,
                            decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: secondaryColor,
                                ),
                                suffixIcon: InkWell(
                                  onTap: () {
                                    if (passToggle == true) {
                                      passToggle = false;
                                    } else {
                                      passToggle = true;
                                    }
                                    setState(() {});
                                  },
                                  child: passToggle
                                      ? Icon(CupertinoIcons.eye_slash_fill)
                                      : Icon(CupertinoIcons.eye_fill),
                                ),
                                hintText: "Password",
                                hintStyle: TextStyle(color: secondaryColor),
                                border: InputBorder.none),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: InkWell(
                        child: const Text("New Here ?",
                            style: TextStyle(color: Colors.grey)),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignupScreen()),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: 10, bottom: 10, right: 30, left: 30),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          minimumSize: const Size(double.infinity, 50),
                          shape: const StadiumBorder(),
                        ),
                        child: const Text(
                          "LogIn",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          AuthService().login(email, password).then((val) {
                            if (val.data['success']) {
                              token = val.data['token'];
                              Fluttertoast.showToast(
                                  msg: 'LoggedIn successfully',
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor: Colors.green,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Navbar()),
                              );
                            }
                          });
                        },
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
