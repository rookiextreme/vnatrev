import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:vnat/common/MiscFunctions.dart';
import 'package:vnat/models/AttendanceModel.dart';
import 'package:vnat/screens/attendance/AttendanceCameraView.dart';
import 'package:vnat/screens/attendance/AttendanceController.dart';
import 'package:vnat/screens/attendance/AttendanceHistoryController.dart';
import 'package:vnat/screens/attendance/clockout/subview/ClockOutAddress.dart';
import 'package:vnat/screens/attendance/clockout/subview/ClockOutMapView.dart';
import 'package:vnat/screens/dashboard/view/Dashboard.dart';

class ClockOutMap extends StatefulWidget {
  static const route = 'map-screen';

  int clockType;

  ClockOutMap({super.key, required this.clockType});

  @override
  State<ClockOutMap> createState() => _ClockOutMapState();
}

class _ClockOutMapState extends State<ClockOutMap> {
  bool isLoading = true;
  int _selectedIndex = 0;

  List<Widget> actionButtons = [];

  Widget getImageWidget(AttendanceModel attModel) {
    if (attModel.selfFile != null) {
      return Image.file(
        File(attModel.selfFile!.path),
        width: 100,
        height: 150,
        fit: BoxFit.fill,
      );
    } else {
      return const Icon(
        Icons.no_photography_outlined,
        size: 100,
      );
    }
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

  void initAttendance() async {
    await Provider.of<AttendanceController>(context, listen: false)
        .initAttendance(widget.clockType);
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    initAttendance();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ClockOutMap oldWidget) {
    super.didUpdateWidget(oldWidget);
    isLoading = true;
    Provider.of<AttendanceController>(context, listen: false).resetCur();
    initAttendance();
  }

  @override
  Widget build(BuildContext context) {
    var attClass = Provider.of<AttendanceController>(context);

    if (isLoading) {
      EasyLoading.show(status: '...Preparing Location Data');
      return Container();
    } else {
      EasyLoading.dismiss();
      return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff020080),
          title: Text('Clock Out Today'),
        ),
        body: Stack(
          children: [
            ClockOutMapView(),
            ClockOutAddress(
              address: attClass.getCurAttendance().address,
              imageWidget: getImageWidget(attClass.getCurAttendance()),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FloatingActionButton(
                  backgroundColor: const Color(0xffb200080),
                  onPressed: () {
                    Navigator.pushNamed(context, AttendanceCameraView.route);
                  },
                  child: const Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
              ],
            ),
          ],
        ),
      );
    }
  }
}
