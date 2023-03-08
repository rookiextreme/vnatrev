import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:vnat/models/AttendanceModel.dart';
import 'package:vnat/screens/attendance/AttendanceCameraView.dart';
import 'package:vnat/screens/attendance/AttendanceController.dart';
import 'package:vnat/screens/attendance/clockin/subview/ClockInAddress.dart';
import 'package:vnat/screens/attendance/clockin/subview/ClockInMapView.dart';

class ClockInMap extends StatefulWidget {
  static const route = 'map-screen';

  int clockType;

  ClockInMap({super.key, required this.clockType});

  @override
  State<ClockInMap> createState() => _ClockInMapState();
}

class _ClockInMapState extends State<ClockInMap> {
  bool isLoading = true;

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
  void didUpdateWidget(covariant ClockInMap oldWidget) {
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
        body: Stack(
          children: [
            ClockInMapView(),
            ClockInAddress(
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
