import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:vnat/common/MiscFunctions.dart';
import 'package:vnat/screens/attendance/AttendanceController.dart';
import 'package:vnat/screens/attendance/AttendanceHistoryController.dart';
import 'package:vnat/screens/attendance/history/AttendanceHistoryView.dart';
import 'package:vnat/screens/dashboard/view/Dashboard.dart';
import 'package:vnat/screens/main/drawer/DrawerView.dart';
import 'package:vnat/screens/attendance/clockin/ClockInMap.dart';

class MainAttendanceView extends StatefulWidget {
  static const route = 'attendance';

  const MainAttendanceView({super.key});

  @override
  State<MainAttendanceView> createState() => _MainAttendanceViewState();
}

class _MainAttendanceViewState extends State<MainAttendanceView> {
  int _selectedIndex = 0;

  String appLabel = '';
  Object? arguments;

  List<Widget> actionButtons = [];

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static final List<Widget> _widgetOptions = <Widget>[
    ClockInMap(
      clockType: 0,
    ),
    ClockInMap(
      clockType: 1,
    ),
    AttendanceHistoryView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      actionWidget();
      if (index == 2) {
        EasyLoading.dismiss();
        appLabel = 'Attendance History';
      } else {
        setLabel();
      }
    });
  }

  void actionWidget() {
    if (_selectedIndex != 2) {
      actionButtons = [
        IconButton(
          onPressed: () async {
            await Provider.of<AttendanceController>(context, listen: false)
                .initAttendance(_selectedIndex);
          },
          icon: Icon(Icons.refresh_outlined),
        ),
        IconButton(
          onPressed: () async {
            await Provider.of<AttendanceController>(context, listen: false)
                .saveAttendance(_selectedIndex)
                .then(
              (value) {
                var status = value['status'];
                var late = value['late'];
                if (status == 1) {
                  if (late == 0) {
                    simple_alert(context, 'Succesfully Clocked', 'Thank You!',
                        AlertType.success, 'Ok', () {
                      Navigator.popAndPushNamed(context, Dashboard.route);
                    });
                  } else {
                    simple_alert(context, 'Succesfully Clocked',
                        'You\'re Late!', AlertType.warning, 'Ok', () {
                      Navigator.popAndPushNamed(context, Dashboard.route);
                    });
                  }
                } else if (status == 4) {
                  simple_alert(
                      context,
                      'WHOOPS!',
                      'Please Check Your Location and Your Picture Cannot Be Empty',
                      AlertType.warning,
                      'Ok', () {
                    Navigator.pop(context);
                  });
                } else {
                  return;
                }
              },
            );
          },
          icon: Icon(Icons.save),
        ),
      ];
    } else {
      actionButtons = [
        IconButton(
          onPressed: () async {
            await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1994),
                    lastDate: DateTime(2101))
                .then(
              (value) {
                Provider.of<AttendanceHistoryController>(context, listen: false)
                    .refreshList((value!));
              },
            );
          },
          icon: const Icon(Icons.date_range),
        ),
      ];
    }
  }

  @override
  void initState() {
    setLabel();
    actionWidget();
    super.initState();
  }

  void setLabel() {
    appLabel = _selectedIndex == 0
        ? 'Attendance - Clock In'
        : 'Attendance - Clock Out';
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: Text(appLabel),
        backgroundColor: const Color(0xff020080),
        actions: actionButtons,
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      drawer: DrawerView(),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.punch_clock,
              color: Colors.green,
            ),
            label: 'Clock In',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.punch_clock,
              color: Colors.red,
            ),
            label: 'Clock Out',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.history,
              color: Color(0xff020080),
            ),
            label: 'History',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
