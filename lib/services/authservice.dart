import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthService {
  Dio dio = new Dio();
  login(email, password) async {
    try {
      return await dio.post('http://192.168.183.1:4000/login',
          data: {"email": email, "password": password},
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      Fluttertoast.showToast(
          msg: e.response?.data['msg'] ?? 'Unknown error occurred',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  register(username, email, phone, password) async {
    return await dio.post('http://192.168.183.1:4000/register',
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
    return await dio.get('http://192.168.183.1:4000/profile');
  }
}
