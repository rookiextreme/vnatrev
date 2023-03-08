import 'package:analog_clock/analog_clock.dart';
import 'package:flutter/material.dart';
import 'package:slide_digital_clock/slide_digital_clock.dart';

class AnalogWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;

    return Container(
      child: DigitalClock(
        areaHeight: height / 7,
        areaWidth: width / 1.7,
        areaAligment: AlignmentDirectional.center,
        areaDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.redAccent,
        ),
        digitAnimationStyle: Curves.elasticIn,
        hourMinuteDigitTextStyle: TextStyle(
          color: Colors.yellow,
          fontSize: 60,
        ),
        hourMinuteDigitDecoration: BoxDecoration(
        ),
        secondDigitDecoration: BoxDecoration(),
      ),
    );
  }
}
