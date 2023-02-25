import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthService {
  Dio dio = new Dio();
  login(email, password) async {
    return await dio.post('https://medapp-jts3.onrender.com/login',
        data: {"email": email, "password": password},
        options: Options(contentType: Headers.formUrlEncodedContentType));
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

  profile(token) async {
    dio.options.headers['Authorization'] = 'Bearer $token';
    return await dio.get('https://medapp-jts3.onrender.com/profile');
  }
}
