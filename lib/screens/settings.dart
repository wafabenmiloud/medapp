// ignore_for_file: prefer_const_constructors

import 'package:chatapp/constants.dart';
import 'package:chatapp/screens/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 50, left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Settings",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 30),
                ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage("images/doctor1.jpg"),
                  ),
                  title: Text(
                    "Wafa",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25),
                  ),
                  subtitle: Text("Profile"),
                ),
                Divider(height: 50),
                ListTile(
                  onTap: () {},
                  leading: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.blue.shade100, shape: BoxShape.circle),
                      child: Icon(
                        CupertinoIcons.person,
                        color: Colors.blue,
                        size: 25,
                      )),
                  title: Text(
                    "Profile",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios_rounded),
                ),
                SizedBox(height: 20),
                ListTile(
                  onTap: () {},
                  leading: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.amber.shade100, shape: BoxShape.circle),
                      child: Icon(
                        Icons.notifications_none_outlined,
                        color: Colors.amber,
                        size: 25,
                      )),
                  title: Text(
                    "Notifications",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios_rounded),
                ),
                SizedBox(height: 20),
                ListTile(
                  onTap: () {},
                  leading: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.deepPurple.shade100,
                          shape: BoxShape.circle),
                      child: Icon(
                        Icons.privacy_tip_outlined,
                        color: Colors.deepPurple,
                        size: 25,
                      )),
                  title: Text(
                    "Privacy",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios_rounded),
                ),
                SizedBox(height: 20),
                ListTile(
                  onTap: () {},
                  leading: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.green.shade100, shape: BoxShape.circle),
                      child: Icon(
                        Icons.settings_suggest_outlined,
                        color: Colors.green,
                        size: 25,
                      )),
                  title: Text(
                    "General",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios_rounded),
                ),
                SizedBox(height: 20),
                ListTile(
                  onTap: () {},
                  leading: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.indigo.shade100,
                          shape: BoxShape.circle),
                      child: Icon(
                        Icons.info_outline_rounded,
                        color: Colors.indigo,
                        size: 25,
                      )),
                  title: Text(
                    "About Us",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios_rounded),
                ),
                Divider(height: 40),
                SizedBox(height: 20),
                ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeScreen()),
                    );
                  },
                  leading: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.red.shade100, shape: BoxShape.circle),
                      child: Icon(
                        Icons.logout,
                        color: Colors.red,
                        size: 25,
                      )),
                  title: Text(
                    "LogOut",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios_rounded),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
