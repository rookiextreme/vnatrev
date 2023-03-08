import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vnat/common/Location.dart';
import 'package:vnat/models/AttendanceModel.dart';
import 'package:http/http.dart' as http;

class AttendanceController extends ChangeNotifier {
  AttendanceModel curAttendanceModel = AttendanceModel(
    address: '',
    latitude: 0.00,
    longitude: 0.00,
    in_type: 0,
  );

  Future<void> initAttendance(in_type) async {
    Position pos = await Location().determinePosition();
    String address = await Location().getAddress(3.228091, 101.652546);

    curAttendanceModel = AttendanceModel(
      address: address,
      latitude: 3.228091,
      longitude: 101.652546,
      in_type: in_type,
    );
    notifyListeners();
  }

  AttendanceModel getCurAttendance() {
    return curAttendanceModel;
  }

  void setPicture(XFile file) {
    var model = getCurAttendance();
    model.selfFile = file;
    notifyListeners();
  }

  void resetCur() {
    curAttendanceModel = AttendanceModel(
        address: '',
        latitude: 0.00,
        longitude: 0.00,
        in_type: 0,
        selfFile: null);
  }

  Future<dynamic> saveAttendance(int clockType) async {
    var model = getCurAttendance();
    var url = Uri.http('10.0.2.2:8000', '/api/user/save-attendance');
    var getShared = await SharedPreferences.getInstance();
    var bearer = getShared.getString('token');

    if (model.selfFile == null ||
        (model.latitude == 0.00 && model.longitude == 0.00)) {
      return {'status': 4};
    }

    var data = {
      'latitude': model.latitude.toString(),
      'longitude': model.longitude.toString(),
      'address': model.address.toString(),
      'type': model.in_type.toString(),
      'clock_type': clockType.toString(),
      'pic': base64Encode(File(model.selfFile!.path).readAsBytesSync()),
    };

    var response = await http.post(
      url,
      headers: {
        // 'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $bearer',
      },
      body: data,
    );

    var statusCode = response.statusCode;
    print(jsonDecode(response.body));
    if (statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return jsonDecode(response.body);
    }
  }
}
