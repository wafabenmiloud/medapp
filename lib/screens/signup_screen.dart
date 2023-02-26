// ignore_for_file: prefer_const_constructors

import 'package:chatapp/services/authservice.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:chatapp/constants.dart';

import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool passToggle = true;
  var username, email, phone, password;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: Color(0XFFECEEFF)),
      home: Scaffold(
        body: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Padding(
                  padding: EdgeInsets.all(50),
                  child: SvgPicture.asset('images/user.svg')),
            ),
            Expanded(
                flex: 3,
                child: Column(
                  children: [
                    Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.only(right: 30, left: 30),
                          color: Colors.white,
                          child: TextField(
                            onChanged: (value) {
                              username = value;
                            },
                            decoration: InputDecoration(
                                prefixIcon:
                                    Icon(Icons.person, color: secondaryColor),
                                hintText: "Username",
                                hintStyle: TextStyle(color: secondaryColor),
                                border: InputBorder.none),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.only(right: 30, left: 30),
                          color: Colors.white,
                          child: TextField(
                            onChanged: (value) {
                              email = value;
                            },
                            decoration: InputDecoration(
                                prefixIcon:
                                    Icon(Icons.email, color: secondaryColor),
                                hintText: "Email",
                                hintStyle: TextStyle(color: secondaryColor),
                                border: InputBorder.none),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.only(right: 30, left: 30),
                          color: Colors.white,
                          child: TextField(
                            onChanged: (value) {
                              phone = value;
                            },
                            decoration: InputDecoration(
                                prefixIcon:
                                    Icon(Icons.phone, color: secondaryColor),
                                hintText: "Phone",
                                hintStyle: TextStyle(color: secondaryColor),
                                border: InputBorder.none),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.only(right: 30, left: 30),
                          color: Colors.white,
                          child: TextField(
                            onChanged: (value) {
                              password = value;
                            },
                            obscureText: passToggle ? true : false,
                            decoration: InputDecoration(
                                prefixIcon:
                                    Icon(Icons.lock, color: secondaryColor),
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
                        child: const Text("Already have an account?",
                            style: TextStyle(color: Colors.grey)),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()),
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
                          "SignUp",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          AuthService()
                              .register(username, email, phone, password)
                              .then((val) {
                            if (val.data['success']) {
                              // token = val.data['token'];
                              Fluttertoast.showToast(
                                  msg: 'User added successfully',
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor: Colors.green,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginScreen()),
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
