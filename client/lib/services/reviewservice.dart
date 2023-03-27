import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReviewService {
  Dio dio = new Dio();

  addreview(id, rate, review) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final response = await dio.post(
      'https://medapp-jts3.onrender.com/addreview/${id}',
      data: {
        "rate": rate,
        "review": review,
      },
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
        contentType: Headers.jsonContentType,
      ),
    );
    print(response);
    return response;
  }

  updatereview(id, rate, review) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final response = await dio.put(
      'https://medapp-jts3.onrender.com/updatereview/$id',
      data: {
        "rate": rate,
        "review": review,
      },
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
        contentType: Headers.jsonContentType,
      ),
    );
    return response;
  }

  deletereview(id) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final res = await dio.delete(
      'https://medapp-jts3.onrender.com/deletereview/$id',
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
        contentType: Headers.jsonContentType,
      ),
    );
  }
}
