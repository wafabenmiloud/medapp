// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:chatapp/constants.dart';
import 'package:chatapp/screens/appointment.dart';
import 'package:chatapp/screens/book_appointment.dart';
import 'package:chatapp/screens/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List symptoms = ["Temperature", "Snuffle", "Fever", "Cough", "Cold"];
  List imgs = [
    "doctor1.jpg",
    "doctor2.jpg",
    "doctor3.jpg",
    "doctor4.jpg",
    "doctor1.jpg",
    "doctor2.jpg",
    "doctor3.jpg",
    "doctor4.jpg",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hi, Wafa!',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          '28 Feb, 2023',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(12)),
                      child: Icon(
                        Icons.notifications,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                //search bar
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white),
                  padding: EdgeInsets.all(15),
                  child: Row(
                    children: [
                      Icon(
                        Icons.search,
                        color: secondaryColor,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Search',
                        style: TextStyle(color: secondaryColor),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'How do you feel today?',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          'You need help ? Book an appointment now.',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                //how do uu feel
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(12)),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const BookAppointment()),
                          );
                        },
                        child: Icon(
                          Icons.add,
                          size: 45,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(12)),
                      child: SvgPicture.asset(
                        "images/good.svg",
                        width: 40,
                        height: 50,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(12)),
                      child: SvgPicture.asset(
                        "images/bad.svg",
                        width: 70,
                        height: 50,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 25),
          Expanded(
              child: Container(
            padding: EdgeInsets.all(25),
            color: Colors.white,
            child: Center(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'What are your symptoms ?',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 70,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: symptoms.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            padding: EdgeInsets.symmetric(horizontal: 25),
                            decoration: BoxDecoration(
                                color: secondaryColor,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 4,
                                    spreadRadius: 2,
                                  )
                                ]),
                            child: Center(
                              child: Text(
                                symptoms[index],
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ),
                            ),
                          );
                        }),
                  ),

                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Nearby Doctors',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Icon(Icons.location_on)
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  //doctors
                  ListView.builder(
                    itemCount: 8,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Appointment()),
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.only(top: 15),
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                  color: Colors.black12.withOpacity(0.05),
                                  borderRadius: BorderRadius.circular(16)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  CircleAvatar(
                                    radius: 35,
                                    backgroundImage:
                                        AssetImage("images/${imgs[index]}"),
                                  ),
                                  SizedBox(width: 20),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        "Dr. Doctor Name",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black54),
                                      ),
                                      Text(
                                        "Therapist",
                                        style: TextStyle(color: Colors.black45),
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.star,
                                            color: Colors.amber.shade400,
                                          ),
                                          Text(
                                            "4.9",
                                            style: TextStyle(
                                                color: Colors.black45),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  )
                ],
              ),
            ),
          ))
        ],
      ),
    );
  }
}
