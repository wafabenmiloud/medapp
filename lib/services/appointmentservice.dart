import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppointmentService {
  Dio dio = new Dio();

  addappoint(doctor, date, time) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final response = await dio.post(
      'http://localhost:4000/addappoint',
      data: {
        "date": date,
        "time": time,
        "doctorname": doctor,
      },
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
        contentType: Headers.jsonContentType,
      ),
    );
    return response;
  }

  updateappoint(id, date, time) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final response = await dio.put(
      'http://localhost:4000/updateappoint/$id',
      data: {
        "date": date,
        "time": time,
      },
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
        contentType: Headers.jsonContentType,
      ),
    );
    return response;
  }

  deleteappoint(id) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final res = await dio.delete(
      'http://localhost:4000/deleteappoint/$id',
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
        contentType: Headers.jsonContentType,
      ),
    );
  }
}
