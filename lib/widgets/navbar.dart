// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:chatapp/screens/dashboard.dart';
import 'package:chatapp/screens/schedule.dart';
import 'package:chatapp/screens/settings.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/constants.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int _selectedIndex = 0;
  final _screens = [Dashboard(), Schedule(), Settings()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _screens[_selectedIndex],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: primaryColor,
        color: Colors.white,
        animationDuration: Duration(milliseconds: 300),
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          Icon(Icons.home_filled),
          Icon(Icons.calendar_month),
          Icon(Icons.settings)
        ],
      ),
    );
  }
}
