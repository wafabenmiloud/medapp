// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:chatapp/constants.dart';
import 'package:chatapp/screens/dashboard.dart';
import 'package:chatapp/screens/schedule.dart';
import 'package:chatapp/screens/update_appointment.dart';
import 'package:chatapp/services/appointmentservice.dart';
import 'package:chatapp/widgets/navbar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

var completed = [];

class CompletedSchedule extends StatefulWidget {
  const CompletedSchedule({super.key});

  @override
  State<CompletedSchedule> createState() => _CompletedScheduleState();
}

class _CompletedScheduleState extends State<CompletedSchedule> {
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    Dio dio = new Dio();
    dio.options.headers['Authorization'] = 'Bearer $token';
    final res = await dio.get('http://localhost:4000/getappoint');
    final data = res.data;
    final completedAppointments = data['completedAppointments'];
    setState(() {
      completed = completedAppointments;
    });
  }

  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: completed.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final appointment = completed[index];

        final doctorname = appointment['doctorname'];
        final date = appointment['date'];
        final time = appointment['time'];
        final formattedDate = DateTime.parse(date).toLocal();

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 5),
                margin: EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: primaryColor),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(
                          doctorname,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text("Therapist"),
                        trailing: CircleAvatar(
                          radius: 25,
                          backgroundImage: AssetImage("images/doctor1.jpg"),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Divider(
                          thickness: 1,
                          height: 20,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                Icons.calendar_month,
                                color: Colors.black54,
                              ),
                              SizedBox(width: 5),
                              Text(
                                "${formattedDate.day}/${formattedDate.month}/${formattedDate.year}",
                                style: TextStyle(color: Colors.black54),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.access_time_filled,
                                color: Colors.black54,
                              ),
                              SizedBox(width: 5),
                              Text(
                                " $time",
                                style: TextStyle(color: Colors.black54),
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () {
                              final id = appointment['_id'];
                              AppointmentService().deleteappoint(id);
                              Fluttertoast.showToast(
                                  msg: 'Appointment Canceled',
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor: Colors.green,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            },
                            child: Container(
                              width: 150,
                              padding: EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                  color: Colors.amber.shade400,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                child: Text(
                                  "Cancel",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              final id = appointment['_id'];
                              final doctor = appointment['doctorname'];
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return UpdateAppointment(
                                    id: id, doctor: doctor);
                              }));
                            },
                            child: Container(
                              width: 150,
                              padding: EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                  color: Colors.amber.shade400,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                child: Text(
                                  "Reschedule",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
