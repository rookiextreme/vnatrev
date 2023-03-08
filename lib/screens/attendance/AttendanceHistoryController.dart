import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:vnat/models/AttendanceListModel.dart';

DateTime curDate = DateTime.now();

class AttendanceHistoryController extends ChangeNotifier {
  Future<List<AttendanceListModel>> getAttendanceList() async {
    List<AttendanceListModel> attList = [];

    var url = Uri.http('10.0.2.2:8000', '/api/user/history-attendance');
    var getShared = await SharedPreferences.getInstance();
    var bearer = getShared.getString('token');

    var data = {
      'date': curDate.toString(),
    };

    var response = await http.post(
      url,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $bearer',
      },
      body: data,
    );

    if (response.statusCode == 200) {
      List<dynamic> result = jsonDecode(response.body)['data'];
      if (result.isNotEmpty) {
        for (var r in result) {
          attList.add(
            AttendanceListModel(
              id: r['id'],
              user_id: r['user_id'],
              currentDate: r['curentDate'],
              latitude_in: r['latitude_in'],
              longitude_in: r['longitude_in'],
              time_in: r['time_in'],
              time_out: r['time_out'],
              photo_in: r['photo_in'],
              reason_in: r['reason_in'],
              latitude_out: r['latitude_out'],
              longitude_out: r['longitude_out'],
              photo_out: r['photo_out'],
              reason_out: r['reason_out'],
              lateStatus: r['late_status'],
            ),
          );
        }

        return attList;
      } else {
        print(attList);
        return [];
      }
    } else {
      return [];
    }
  }

  void refreshList(DateTime awDate) {
    curDate = awDate;
    notifyListeners();
  }
}
