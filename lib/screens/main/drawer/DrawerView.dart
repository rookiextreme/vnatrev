import 'package:flutter/material.dart';
import 'package:vnat/screens/attendance/MainAttendanceView.dart';
import 'package:vnat/screens/dashboard/view/Dashboard.dart';

class DrawerView extends StatelessWidget {
  const DrawerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Image.asset('images/mantasoft.png'),
          ),
          ListTile(
            onTap: () => Navigator.popAndPushNamed(context, Dashboard.route),
            leading: Icon(Icons.home_filled),
            title: Text(
              'Dashboard',
              style: TextStyle(color: Color(0xff020080)),
            ),
          ),
          ListTile(
            onTap: () =>
                Navigator.popAndPushNamed(context, MainAttendanceView.route),
            leading: Icon(Icons.lock_clock),
            title: Text(
              'Attendance',
              style: TextStyle(color: Color(0xff020080)),
            ),
          ),
          const Divider(color: Colors.blueGrey),
          const ListTile(
            leading: Icon(Icons.person),
            title: Text(
              'Profile',
              style: TextStyle(color: Color(0xff020080)),
            ),
          ),
          const ListTile(
            leading: Icon(Icons.logout_rounded),
            title: Text(
              'Logout',
              style: TextStyle(color: Color(0xff020080)),
            ),
          ),
        ],
      ),
    );
  }
}
