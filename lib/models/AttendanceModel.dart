import 'package:camera/camera.dart';

class AttendanceModel {
  XFile? selfFile;
  String address;
  double latitude;
  double longitude;
  bool status;
  int in_type;

  AttendanceModel(
      {this.selfFile,
      this.address = 'Getting Address',
      this.latitude = 0.00,
      this.longitude = 0.00,
      this.status = true,
      this.in_type = 0});
}
