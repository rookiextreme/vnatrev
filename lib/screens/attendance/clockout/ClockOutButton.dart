import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:vnat/models/AttendanceListModel.dart';
import 'package:vnat/models/AttendanceModel.dart';
import 'package:vnat/screens/attendance/AttendanceHistoryController.dart';
import 'package:vnat/screens/attendance/clockout/ClockOutListToday.dart';
import 'package:vnat/screens/attendance/clockout/ClockOutListYesterday.dart';
import 'package:vnat/screens/attendance/history/AttendanceHistoryView.dart';

void main() => runApp(const ClockOutButton());

class ClockOutButton extends StatelessWidget {
  static const route = 'clock_out';

  const ClockOutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  @override
  Widget build(BuildContext context) {
    final ButtonStyle style =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, ClockOutListYesterday.route);
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff020080),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 70),
                textStyle:
                    const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            child: const Text('Yesterday - List'),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, ClockOutListToday.route);
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff020080),
                padding:
                    const EdgeInsets.symmetric(horizontal: 47, vertical: 70),
                textStyle:
                    const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            child: const Text('Today - List'),
          ),
        ],
      ),
    );
  }
}
