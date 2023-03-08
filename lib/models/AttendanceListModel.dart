import 'package:flutter/material.dart';

class AttendanceListModel {
  final user_id;
  final id;
  final currentDate;
  final latitude_in;
  final longitude_in;
  final time_in;
  final photo_in;
  final reason_in;
  final latitude_out;
  final longitude_out;
  final photo_out;
  final reason_out;
  final lateStatus;
  final time_out;

  AttendanceListModel(
      {this.user_id,
      this.id,
      this.currentDate,
      this.latitude_in,
      this.longitude_in,
      this.time_in,
      this.photo_in,
      this.reason_in,
      this.latitude_out,
      this.longitude_out,
      this.photo_out,
      this.reason_out,
      this.time_out,
      this.lateStatus});
}
