import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:vnat/common/MiscFunctions.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:vnat/screens/dashboard/view/Dashboard.dart';

class AuthController extends ChangeNotifier {
  void auth(BuildContext context, String username, String password) async {
    EasyLoading.show(status: 'loading...');
    try {
      var url = Uri.http('10.0.2.2:8000', '/api/user/get-token');

      var response = await http
          .post(url, body: {'username': username, 'password': password});

      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        var user = await getUser(body['token']);

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', body['token']);
        await prefs.setInt('id', user['id']);
        await prefs.setString('name', user['name']);
        await prefs.setString('email', user['email']);

        // ignore: use_build_context_synchronously
        Navigator.popAndPushNamed(context, Dashboard.route);
      } else {
        // ignore: use_build_context_synchronously
        simple_alert(context, 'Invalid Username Or Password',
            'Please Try Again', AlertType.error, 'OK', () {});
      }
    } catch (e) {
      EasyLoading.dismiss();
      simple_alert(context, 'WHOOPS!', 'Something Went Wrong', AlertType.error,
          'OK', () {});
    }
  }

  Future<dynamic> getUser(String bearer) async {
    try {
      var url = Uri.http('10.0.2.2:8000', '/api/user/get-user');

      var response = await http.post(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $bearer',
      });

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return [];
      }
    } catch (e) {
      print(e);
    }
  }
}
