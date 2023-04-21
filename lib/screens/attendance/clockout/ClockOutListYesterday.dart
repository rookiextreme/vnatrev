import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:vnat/models/AttendanceListModel.dart';
import 'package:vnat/models/AttendanceModel.dart';
import 'package:vnat/screens/attendance/clockout/ClockOutListYesterday.dart';
import 'package:vnat/screens/attendance/AttendanceHistoryController.dart';
import 'package:vnat/screens/attendance/clockout/ClockOutMap.dart';

class ClockOutListYesterday extends StatelessWidget {
  static const route = 'clock-in-yesterday-history-view';
  ClockOutListYesterday({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff020080),
        title: Text('Yesterday Listing'),
      ),
      body: SafeArea(
          child: FutureBuilder(
        future: Provider.of<AttendanceHistoryController>(context)
            .getAttendanceList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            EasyLoading.show(status: 'Loading Attendance\'s');
            return Container();
          }

          EasyLoading.dismiss();
          if (snapshot.data!.isNotEmpty) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                AttendanceListModel att = snapshot.data![index];

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                          border: Border.all(
                            color: att.lateStatus == 0
                                ? Colors.green.shade200
                                : Colors.red.shade200,
                            width: 2,
                          ),
                        ),
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      att.lateStatus == 0
                                          ? Icon(
                                              Icons.lock_clock,
                                              color: Colors.green,
                                              size: 70,
                                            )
                                          : Icon(
                                              Icons.lock_clock,
                                              color: Colors.red,
                                              size: 70,
                                            ),
                                      Text(
                                        att.lateStatus == 0
                                            ? 'ON TIME'
                                            : 'LATE',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: att.lateStatus == 0
                                                ? Colors.green.shade400
                                                : Colors.red.shade400),
                                      ),
                                      Text(
                                        att.currentDate,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(
                                        Icons.info_outline_rounded,
                                        size: 70,
                                        color: Colors.blue.shade400,
                                      ),
                                      Text(
                                        'IN : ${att.time_in}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        'HOME : ${att.time_out ?? 'UNCLOCK'}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.network(
                                        'http://10.0.2.2:8000/api/attendance/${att.photo_in}',
                                        height: 110,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute<void>(
                                            builder: (BuildContext context) =>
                                                ClockOutMap(clockType: 1),
                                          ),
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Color(0xff020080),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 10),
                                          textStyle: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold)),
                                      child: const Text('Yesterday - List'),
                                    )
                                  ]),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return Center(
              child: Text('No Result'),
            );
          }
        },
      )),
    );
  }
}
