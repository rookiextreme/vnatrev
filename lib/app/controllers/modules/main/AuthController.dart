import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:maps_toolkit/maps_toolkit.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:vnatpro2/app/systemConst.dart';
import 'package:http/http.dart' as http;

class AuthController extends ChangeNotifier{

  Future<bool> login(username, password)async {
    bool pass = true;
    var tokenUrl = Uri.parse('${baseURL}api/user/get-token');

    http.Response tokenData = await http.post(tokenUrl, headers: {}, body: {
      'username': username,
      'password': password
    });

    if(tokenData.statusCode == 200){
      var parseToken = jsonDecode(tokenData.body);
      var userUrl = Uri.parse('${baseURL}api/user/get-user');
      http.Response userData = await http.post(userUrl, headers: {
        'Authorization': 'Bearer ${parseToken["token"]}'
      });

      if(userData.statusCode == 200){
        var parseUserData = jsonDecode(userData.body);
        await setValue('id', parseUserData['id']);
        await setValue('username', parseUserData['username']);
        await setValue('name', parseUserData['name']);
        await setValue('email', parseUserData['email']);
        await setValue('token', parseToken["token"]);
      }
    }else{
      pass = false;
    }
    return pass;
  }

  Future<void> logout() async {
    var tokenUrl = Uri.parse('${baseURL}api/user/delete-user');

    await http.post(tokenUrl, headers: {
      'Authorization': 'Bearer ${getToken()}'
    });
    await removeKey('id');
    await removeKey('username');
    await removeKey('name');
    await removeKey('email');
    await removeKey('token');
  }

  String getUsername(){
    return getStringAsync('username');
  }

  String getEmail(){
    return getStringAsync('email');
  }

  String getUserid(){
    return getStringAsync('id');
  }

  String getName(){
    return getStringAsync('name');
  }

  String getToken(){
    return getStringAsync('token');
  }

  Future<void> calculatePolygon()async{
    List<LatLng> points = [
      LatLng(3.1553354, 101.6894378),
      LatLng(3.1553675, 101.6871418),
      LatLng(3.1521323, 101.6899528),
      LatLng(3.1529786, 101.6913368),
    ];
    var test = PolygonUtil.containsLocation(LatLng(3.1470, 101.7373), points, true);
    print(test);
  }
}