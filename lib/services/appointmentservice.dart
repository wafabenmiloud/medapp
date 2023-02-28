import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppointmentService {
  Dio dio = new Dio();

  addappoint(date, time, doctor) async {
    return await dio.post('http://localhost:4000/addappoint',
        data: {
          "date": date,
          "time": time,
          "doctor": doctor,
        },
        options: Options(contentType: Headers.formUrlEncodedContentType));
  }

  updateappoint(date, time) async {
    return await dio.put('http://localhost:4000/updateappoint',
        data: {
          "date": date,
          "time": time,
        },
        options: Options(contentType: Headers.formUrlEncodedContentType));
  }

  deleteappoint(id) async {
    return await dio.delete('http://localhost:4000/deleteappoint',
        data: {
          "id": id,
        },
        options: Options(contentType: Headers.formUrlEncodedContentType));
  }
}
