import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:vnatpro2/app/controllers/modules/main/navbarController.dart';
import 'package:vnatpro2/app/views/constantWidget/ConstantWidget.dart';
import 'package:vnatpro2/app/views/modules/attendance/history/historyScreen.dart';
import 'package:vnatpro2/app/views/modules/dashboard/dashboard.dart';
import 'package:vnatpro2/app/views/navbar/navbarscreen.dart';

class CameraWidget extends StatefulWidget {
  @override
  State<CameraWidget> createState() => _CameraWidgetState();
}

class _CameraWidgetState extends State<CameraWidget> {
  CameraController? cameraController;
  bool isLoad = true;

  void initMainCamStep1() async {
    final cameras = await availableCameras();
    cameraController = CameraController(cameras.last, ResolutionPreset.high);
    try {
      await cameraController?.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {
          isLoad = false;
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

  @override
  void dispose() {
    super.dispose();
    cameraController?.dispose();
  }

  @override
  void initState() {
    super.initState();
    initMainCamStep1();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Take a picture'),
        backgroundColor: Colors.orangeAccent,
      ),
      body: isLoad
          ? Center(
              child: SpinKitDancingSquare(
                color: Colors.orangeAccent,
              ),
            )
          : CameraPreview(cameraController!),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            displaySnack(context: context, label: 'Taking Picture');
            final image = await cameraController?.takePicture();
            if (!mounted) {
              return;
            }

            showModalBottomSheet(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                )),
                context: context,
                builder: (context) {
                  var reasonEditingController = TextEditingController();

                  return SingleChildScrollView(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            'You\'re Late!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          Container(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Enter Your Reason...',
                              ),
                              maxLines: 5,
                              autofocus: true,
                              controller: reasonEditingController,
                              onChanged: (val) {
                                // reasonEditingController.value;
                              },
                              textInputAction: TextInputAction.go,
                              onSubmitted: (val) {
                                FocusScopeNode currentFocus =
                                    FocusScope.of(context);
                                if (!currentFocus.hasPrimaryFocus) {
                                  currentFocus.unfocus();
                                }
                                //
                                // Navigator.of(context).pushReplacementNamed(NavbarScreen.url);
                                NavbarScreen().launch(context, isNewTask: true);
                                Provider.of<NavBarController>(context,
                                        listen: false)
                                    .changeTab(0);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                });
          } catch (e) {
            print(e);
          }
        },
        child: const Icon(Icons.camera_alt),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
