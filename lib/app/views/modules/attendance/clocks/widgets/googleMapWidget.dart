import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:vnatpro2/app/controllers/modules/main/LocationController.dart';

class GoogleMapWidget extends StatefulWidget {
  @override
  State<GoogleMapWidget> createState() => _GoogleMapWidgetState();
}

class _GoogleMapWidgetState extends State<GoogleMapWidget> {
  final Completer<GoogleMapController> _mapController = Completer();

  Set<Polygon> _polygon = HashSet<Polygon>();

  List<LatLng> points = [
    LatLng(3.1553354, 101.6894378),
    LatLng(3.1553675, 101.6871418),
    LatLng(3.1521323, 101.6899528),
    LatLng(3.1529786, 101.6913368),
  ];

  initState(){
    super.initState();

    _polygon.add(
        Polygon(
          // given polygonId
          polygonId: PolygonId('1'),
          // initialize the list of points to display polygon
          points: points,
          // given color to polygon
          fillColor: Colors.yellow.withOpacity(0.4),
          // given border color to polygon
          strokeColor: Colors.yellow,
          geodesic: true,
          // given width of border
          strokeWidth: 4,
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    var lc = Provider.of<LocationController>(context);

    return lc.locationStatus
        ? GoogleMap(
            compassEnabled: false,
            polygons: _polygon,
            initialCameraPosition: lc.getCamPos(
              lc.lat,
              lc.long,
            ),
            mapType: MapType.normal,
            onMapCreated: (GoogleMapController controller) {
              _mapController.complete(controller);
            },
            markers: lc.setMarker(),
            scrollGesturesEnabled: false,
            tiltGesturesEnabled: false,
            zoomGesturesEnabled: false,
            zoomControlsEnabled: false,
            mapToolbarEnabled: false,
            buildingsEnabled: false,
            minMaxZoomPreference: const MinMaxZoomPreference(0, 16),
          )
        : const Center(
            child: Text('Loading Map'),
          );
  }
}
