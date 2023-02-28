// ignore_for_file: prefer_const_constructors

import 'package:chatapp/constants.dart';
import 'package:chatapp/screens/home_screen.dart';
import 'package:chatapp/screens/login_screen.dart';
import 'package:chatapp/screens/profile.dart';
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
    return Material(
      color: Colors.white,
      child: ListView(
        padding: EdgeInsets.only(top: 40, right: 12, left: 12),
        physics: BouncingScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Center(
              child: Text(
                "Settings",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 3),
              ),
            ),
          ),
          SizedBox(height: 35),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Profile()),
              );
            },
            leading: CircleAvatar(
              backgroundImage: AssetImage("images/doctor1.jpg"),
            ),
            title: Text(
              "Wafa",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            subtitle: Text("Profile"),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Divider(thickness: 1.5),
          ),
          Column(
            children: [
              ListTile(
                onTap: () {},
                leading: Container(
                  child: Icon(
                    CupertinoIcons.person,
                    color: Colors.blue,
                  ),
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.09),
                      borderRadius: BorderRadius.circular(18)),
                ),
                title: Text(
                  "Theme",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                trailing: Icon(Icons.arrow_forward_ios_rounded),
              ),
              SizedBox(height: 20),
              ListTile(
                onTap: () {},
                leading: Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                        color: Colors.amber.withOpacity(0.09),
                        borderRadius: BorderRadius.circular(18)),
                    child: Icon(
                      Icons.notifications_none_outlined,
                      color: Colors.amber,
                    )),
                title: Text(
                  "Notifications",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                trailing: Icon(Icons.arrow_forward_ios_rounded),
              ),
              SizedBox(height: 20),
              Divider(
                height: 40,
                thickness: 1.5,
              ),
              SizedBox(height: 20),
              ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()),
                  );
                },
                leading: Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.09),
                        borderRadius: BorderRadius.circular(18)),
                    child: Icon(
                      Icons.logout,
                      color: Colors.red,
                    )),
                title: Text(
                  "LogOut",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                trailing: Icon(Icons.arrow_forward_ios_rounded),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
