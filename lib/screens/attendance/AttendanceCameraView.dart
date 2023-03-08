import 'dart:math';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:vnat/screens/attendance/AttendanceController.dart';

class AttendanceCameraView extends StatefulWidget {
  static const route = 'attendance-camera-view';

  const AttendanceCameraView({super.key});

  @override
  State<AttendanceCameraView> createState() => _AttendanceCameraViewState();
}

class _AttendanceCameraViewState extends State<AttendanceCameraView> {
  List<CameraDescription> cameraList = [];
  CameraController? controller;

  bool loadingCamera = true;

  void cameraInit() async {
    WidgetsFlutterBinding.ensureInitialized();
    cameraList = await availableCameras();
    controller = CameraController(cameraList.last, ResolutionPreset.high);
    try {
      await controller?.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {
          loadingCamera = false;
        });
      }).catchError((Object e) {
        if (e is CameraException) {
          switch (e.code) {
            case 'CameraAccessDenied':
              print('User denied camera access.');
              break;
            default:
              print('Handle other errors.');
              break;
          }
        }
      });
    } on CameraException catch (e) {
      debugPrint("camera error $e");
    }
  }

  void captureSelf() async {
    final picturing = await controller?.takePicture().then((XFile? file) {
      if (mounted) {
        if (file != null) {
          Provider.of<AttendanceController>(context, listen: false)
              .setPicture(file);
          EasyLoading.dismiss();
          Navigator.pop(context);
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    cameraInit();
  }

  @override
  void dispose() {
    EasyLoading.dismiss();
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (loadingCamera) {
      EasyLoading.show(status: 'loading camera...');
      return Scaffold(
        appBar: AppBar(
          title: Text('Picture'),
        ),
      );
    } else {
      EasyLoading.dismiss();
      return Scaffold(
        appBar: AppBar(
          title: Text('Picture'),
        ),
        body: SafeArea(
          child: Stack(
            children: [
              CameraPreview(controller!),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FloatingActionButton(
                        backgroundColor: Color(0xffb200080),
                        onPressed: () {
                          EasyLoading.show(status: '...Capturing');
                          captureSelf();
                        },
                        child: Icon(
                          Icons.camera,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 100,
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }
  }
}
