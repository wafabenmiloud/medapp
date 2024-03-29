// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:chatapp/screens/schedule.dart';
import 'package:chatapp/services/appointmentservice.dart';
import 'package:chatapp/widgets/navbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/constants.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class BookAppointment extends StatefulWidget {
  const BookAppointment({super.key});

  @override
  State<BookAppointment> createState() => _BookAppointmentState();
}

class _BookAppointmentState extends State<BookAppointment> {
  TextEditingController dateInput = TextEditingController();
  TextEditingController timeinput = TextEditingController();
  List doctors = [
    "doctor0",
    "doctor1",
    "doctor2",
    "doctor3",
    "doctor4",
    "doctor5",
    "doctor6",
    "doctor7",
  ];
  String selectedDoctor = 'doctor1';

  @override
  void initState() {
    dateInput.text = "";
    timeinput.text = "";
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 50),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.transparent, shape: BoxShape.circle),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 60),
              height: 700,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(30)),
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 40),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.person,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 50,
                        ),
                        DropdownButton<String>(
                          padding: EdgeInsets.all(10),
                          alignment: AlignmentDirectional.centerStart,
                          value: selectedDoctor,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedDoctor = newValue!;
                            });
                          },
                          hint: const Center(
                              child: Text(
                            'Select the doctor',
                            style: TextStyle(color: Colors.grey),
                          )),
                          underline: Container(),
                          items: doctors.map((value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(value,
                                      style: const TextStyle(fontSize: 18))),
                            );
                          }).toList() as List<DropdownMenuItem<String>>,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextField(
                      controller: dateInput,
                      decoration: InputDecoration(
                          icon: Icon(Icons.calendar_today),
                          labelText: "Enter Date"),
                      readOnly: true,
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1950),
                            lastDate: DateTime(2100));

                        if (pickedDate != null) {
                          String formattedDate =
                              DateFormat('yyyy-MM-dd').format(pickedDate);

                          setState(() {
                            dateInput.text = formattedDate;
                          });
                        } else {}
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextField(
                      controller: timeinput,
                      decoration: InputDecoration(
                          icon: Icon(Icons.timer), labelText: "Enter Time"),
                      readOnly: true,
                      onTap: () async {
                        TimeOfDay? pickedTime = await showTimePicker(
                          initialTime: TimeOfDay.now(),
                          context: context,
                        );

                        if (pickedTime != null) {
                          DateTime parsedTime = DateFormat.jm()
                              .parse(pickedTime.format(context).toString());
                          String formattedTime =
                              DateFormat('HH:mm').format(parsedTime);

                          setState(() {
                            timeinput.text = formattedTime;
                          });
                        } else {
                          print("Time is not selected");
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 80),
                    child: InkWell(
                      onTap: () {
                        AppointmentService().addappoint(
                            selectedDoctor, dateInput.text, timeinput.text);
                        Navigator.pop(context, true);
                      },
                      child: Container(
                        width: 250,
                        padding: EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                            color: Colors.amber.shade400,
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Text(
                            "Schedule",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
