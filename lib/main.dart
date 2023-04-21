import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vnat/screens/attendance/AttendanceCameraView.dart';
import 'package:vnat/screens/attendance/AttendanceController.dart';
import 'package:vnat/screens/attendance/AttendanceHistoryController.dart';
import 'package:vnat/screens/attendance/MainAttendanceView.dart';
import 'package:vnat/screens/attendance/history/AttendanceHistoryView.dart';
import 'package:vnat/screens/auth/controller/AuthController.dart';
import 'package:vnat/screens/auth/view/MainAuth.dart';
import 'package:vnat/screens/attendance/clockin/ClockInMap.dart';
import 'package:vnat/screens/attendance/clockout/ClockOutButton.dart';
import 'package:vnat/screens/attendance/clockout/ClockOutListToday.dart';
import 'package:vnat/screens/attendance/clockout/ClockOutListYesterday.dart';
import 'package:vnat/screens/attendance/clockout/ClockOutMap.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:vnat/screens/dashboard/view/Dashboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthController()),
        ChangeNotifierProvider(create: (context) => AttendanceController()),
        ChangeNotifierProvider(
            create: (context) => AttendanceHistoryController()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        routes: {
          // '/': (context) => ClockOutList(),
          '/': (context) => const MainAuth(),
          // ClockInMap.route: (context) => ClockInMap(
          //       clockType: 0,
          //     ),
          Dashboard.route: (context) => Dashboard(),
          MainAttendanceView.route: (context) => MainAttendanceView(),
          AttendanceCameraView.route: (context) => AttendanceCameraView(),
          // AttendanceHistoryView.route: (context) => AttendanceHistoryView(),
          ClockOutButton.route: (context) => ClockOutButton(),
          ClockOutListToday.route: (context) => ClockOutListToday(),
          ClockOutListYesterday.route: (context) => ClockOutListYesterday(),
          // ClockOutMap.route: (context) => ClockOutMap(),
          // ClockOutList.route: (context) => ClockOutList()
        },
        builder: EasyLoading.init(),
      ),
    );
  }
}
