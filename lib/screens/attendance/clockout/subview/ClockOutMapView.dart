import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:vnat/screens/attendance/AttendanceController.dart';
import 'package:point_in_polygon/point_in_polygon.dart';

class ClockOutMapView extends StatelessWidget {
  const ClockOutMapView({super.key});
  @override
  Widget build(BuildContext context) {
    late AnchorPos<dynamic> anchorPos;

    bool isInPolygon = false;

    var curModel =
        Provider.of<AttendanceController>(context).getCurAttendance();

    final markers = <Marker>[
      Marker(
        width: 50,
        height: 50,
        point: LatLng(curModel.latitude, curModel.longitude),
        builder: (ctx) => const FlutterLogo(),
      ),
    ];
    return FlutterMap(
      options: MapOptions(
        center: LatLng(curModel.latitude, curModel.longitude),
        zoom: 17,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'dev.fleaflet.flutter_map.example',
        ),
        MarkerLayer(markers: markers),
        PolygonLayer(
          polygonCulling: false,
          polygons: [
            Polygon(points: [
              LatLng(3.2289459, 101.6519022),
              LatLng(3.2285495, 101.6519344),
              LatLng(3.2268678, 101.6520524),
              LatLng(3.2268463, 101.6538012),
              LatLng(3.2289566, 101.6535544),
              LatLng(3.2289459, 101.6519022),
            ], borderStrokeWidth: 5.0, borderColor: Colors.red),
          ],
        ),
      ],
    );
  }
}
