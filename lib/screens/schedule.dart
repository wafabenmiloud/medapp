// ignore_for_file: prefer_const_constructors

import 'package:chatapp/constants.dart';
import 'package:chatapp/widgets/completed_schedule.dart';
import 'package:chatapp/widgets/upcoming_schedule.dart';
import 'package:flutter/material.dart';

class Schedule extends StatefulWidget {
  const Schedule({super.key});

  @override
  State<Schedule> createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  int _buttonIndex = 0;
  final _ScheduleWidgets = [
    UpcomingSchedule(),
    CompletedSchedule(),
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    "Schedule",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            _buttonIndex = 0;
                          });
                        },
                        child: Container(
                          width: 170,
                          padding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: _buttonIndex == 0
                                  ? primaryColor
                                  : Colors.transparent,
                              boxShadow: [
                                _buttonIndex == 0
                                    ? BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 6,
                                        spreadRadius: 4,
                                      )
                                    : BoxShadow(
                                        color: Colors.transparent,
                                        blurRadius: 0,
                                        spreadRadius: 0,
                                      )
                              ]),
                          child: Center(
                            child: Text(
                              "Upcoming",
                              style: TextStyle(
                                  color: _buttonIndex == 0
                                      ? Colors.white
                                      : Colors.black38,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            _buttonIndex = 1;
                          });
                        },
                        child: Container(
                          width: 170,
                          padding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 10),
                          decoration: BoxDecoration(
                              color: _buttonIndex == 1
                                  ? primaryColor
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                _buttonIndex == 1
                                    ? BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 6,
                                        spreadRadius: 4,
                                      )
                                    : BoxShadow(
                                        color: Colors.transparent,
                                        blurRadius: 0,
                                        spreadRadius: 0,
                                      )
                              ]),
                          child: Center(
                            child: Text(
                              "Completed",
                              style: TextStyle(
                                  color: _buttonIndex == 1
                                      ? Colors.white
                                      : Colors.black38,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                _ScheduleWidgets[_buttonIndex],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
