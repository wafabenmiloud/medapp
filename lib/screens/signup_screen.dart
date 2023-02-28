// ignore_for_file: prefer_const_constructors
import 'dart:math' as math;

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
  Widget topWidget(double screenWidth) {
    return Transform.rotate(
      angle: -35 * math.pi / 180,
      child: Container(
        width: 1.2 * screenWidth,
        height: 1.2 * screenWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(150),
          gradient: const LinearGradient(
            begin: Alignment(-0.2, -0.8),
            end: Alignment.bottomCenter,
            colors: [
              primaryColor,
              Colors.white,
            ],
          ),
        ),
      ),
    );
  }

  bool passToggle = true;
  var username, email, phone, password;
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: -160,
            left: -30,
            child: topWidget(screenSize.width),
          ),
          Column(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(top: 80, bottom: 60),
                  child: Text(
                    "Create an account",
                    style: TextStyle(
                        fontSize: 30,
                        color: secondaryColor,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2),
                  )),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 36, vertical: 5),
                child: SizedBox(
                  height: 60,
                  child: Material(
                    elevation: 8,
                    shadowColor: Colors.black45,
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(30),
                    child: TextField(
                        textAlignVertical: TextAlignVertical.bottom,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: Icon(
                            Icons.person,
                            color: secondaryColor,
                          ),
                          hintText: "Username",
                        ),
                        onChanged: (value) {
                          username = value;
                        }),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 36, vertical: 5),
                child: SizedBox(
                  height: 60,
                  child: Material(
                    elevation: 8,
                    shadowColor: Colors.black45,
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(30),
                    child: TextField(
                        textAlignVertical: TextAlignVertical.bottom,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: Icon(
                            Icons.email,
                            color: secondaryColor,
                          ),
                          hintText: "Email",
                        ),
                        onChanged: (value) {
                          email = value;
                        }),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 36, vertical: 5),
                child: SizedBox(
                  height: 60,
                  child: Material(
                    elevation: 8,
                    shadowColor: Colors.black45,
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(30),
                    child: TextField(
                        textAlignVertical: TextAlignVertical.bottom,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: Icon(
                            Icons.phone,
                            color: secondaryColor,
                          ),
                          hintText: "Phone",
                        ),
                        onChanged: (value) {
                          phone = value;
                        }),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 36, vertical: 5),
                child: SizedBox(
                  height: 60,
                  child: Material(
                    elevation: 8,
                    shadowColor: Colors.black45,
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(30),
                    child: TextField(
                      textAlignVertical: TextAlignVertical.bottom,
                      onChanged: (value) {
                        password = value;
                      },
                      obscureText: passToggle ? true : false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.white,
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
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: InkWell(
                  child: const Text("Already have an account ?",
                      style: TextStyle(color: secondaryColor)),
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
                padding:
                    EdgeInsets.only(top: 10, bottom: 10, right: 40, left: 40),
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
          )
        ],
      ),
    );
  }
}
