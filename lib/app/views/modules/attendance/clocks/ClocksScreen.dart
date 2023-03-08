import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:vnatpro2/app/controllers/modules/main/AuthController.dart';
import 'package:vnatpro2/app/controllers/modules/main/LocationController.dart';
import 'package:vnatpro2/app/views/constantWidget/ConstantWidget.dart';
import 'package:vnatpro2/app/views/modules/attendance/clocks/widgets/cameraWidget.dart';
import 'package:vnatpro2/app/views/modules/attendance/clocks/widgets/googleMapWidget.dart';

class ClocksScreen extends StatefulWidget {
  static const url = '/clock-screen';

  @override
  State<ClocksScreen> createState() => _ClocksScreenState();
}

class _ClocksScreenState extends State<ClocksScreen> {
  void initAll() async {
    try {
      await Provider.of<LocationController>(context, listen: false)
          .checkAndGetPosition();
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    initAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: Text('Clock In Time'),
        actions: [
          IconButton(
            onPressed: () async {
              await Provider.of<AuthController>(context, listen: false)
                  .calculatePolygon();
              // displaySnack(
              //     context: context,
              //     label: 'Refreshing Location. Please Wait..');
              // await Provider.of<LocationController>(context, listen: false)
              //     .refreshLocation()
              //     .then((value) => displaySnack(
              //         context: context, label: 'Location Refresh!'));
            },
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: Stack(
        children: [
          GoogleMapWidget(),
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      'Jalan Sultan Salahuddin, Kuala Lumpur, 50480 Kuala Lumpur, Wilayah Persekutuan Kuala Lumpur',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: FloatingActionButton(
                    backgroundColor: Colors.orangeAccent,
                    onPressed: () {
                      CameraWidget().launch(context);
                    },
                    child: Icon(Icons.photo_camera),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
