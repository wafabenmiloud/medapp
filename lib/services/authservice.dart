import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  Dio dio = new Dio();
  login(email, password) async {
    final response = await dio.post('https://medapp-jts3.onrender.com/login',
        data: {"email": email, "password": password},
        options: Options(contentType: Headers.formUrlEncodedContentType));

    if (response.statusCode == 200) {
      final token = response.data['token'];

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
    }

    return response;
  }

  register(username, email, phone, password) async {
    return await dio.post('https://medapp-jts3.onrender.com/register',
        data: {
          "username": username,
          "email": email,
          "phone": phone,
          "password": password
        },
        options: Options(contentType: Headers.formUrlEncodedContentType));
  }
}
