import 'package:chatapp/screens/book_appointment.dart';
import 'package:chatapp/screens/dashboard.dart';
import 'package:chatapp/screens/home_screen.dart';
import 'package:chatapp/widgets/navbar.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
