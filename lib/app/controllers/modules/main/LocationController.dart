import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class LocationController extends ChangeNotifier{
  double? lat;
  double? long;
  String? curAddress;
  bool locationStatus = false;

  Future<Position> checkAndGetPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    final position = await Geolocator.getCurrentPosition();
    // lat = position.latitude;
    // long = position.longitude;
    lat = 3.1537;
    long = 101.6907;
    locationStatus = true;
    await getAddress(lat, long);
    notifyListeners();
    return position;
  }

  CameraPosition getCamPos(latitude, longitude) {
    return CameraPosition(
      target: LatLng(latitude, longitude),
      zoom: 20,
    );
  }

  Future<void> getAddress(lat, long) async {
    var url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$long&key=AIzaSyByoTztRSLsoTvyVXgtocY4D7F_R7e_EE8');

    http.Response response = await http.get(url);
    var body = jsonDecode(response.body);

    curAddress = body['results'][0]['formatted_address'];
  }

  Set<Marker> setMarker() {
    final Set<Marker> markers = new Set();
    markers.add(Marker(
      markerId: MarkerId('My Home'),
      position: LatLng(lat!, long!),
    ));

    return markers;
  }

  Future<void> refreshLocation() async {
    await checkAndGetPosition();
    notifyListeners();
  }
}