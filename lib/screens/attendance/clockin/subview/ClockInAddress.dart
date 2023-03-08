import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ClockInAddress extends StatelessWidget {
  final Widget? imageWidget;
  final String address;

  const ClockInAddress(
      {super.key, required this.imageWidget, required this.address});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: double.infinity,
          height: 110,
          padding: const EdgeInsets.all(4),
          child: Card(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  const Icon(
                    Icons.my_location,
                    size: 20,
                    color: Colors.purple,
                  ),
                  const Text(
                    'ADDRESS',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    address,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: imageWidget,
            ),
          ),
        ),
      ],
    );
  }
}
