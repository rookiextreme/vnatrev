import 'package:flutter/material.dart';
import 'package:vnat/screens/dashboard/view/subview/DashboardAttendanceSubView.dart';
import 'package:vnat/screens/dashboard/view/subview/DashboardLeaveSubView.dart';
import 'package:vnat/screens/main/drawer/DrawerView.dart';

class Dashboard extends StatelessWidget {
  static const route = 'dashboard';

  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: Text('Dashboard'),
        backgroundColor: const Color(0xff020080),
      ),
      drawer: DrawerView(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DashboardAttendanceSubView(),
              DashboardLeaveSubView(),
            ],
          ),
        ),
      ),
    );
  }
}
