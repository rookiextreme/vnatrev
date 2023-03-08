import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:vnatpro2/app/views/modules/attendance/history/widgets/historyListButtonWidget.dart';

import '../../../../../../main/utils/AppWidget.dart';

class HistoryListWidget extends StatelessWidget {
  late var width;

  @override
  Widget build(BuildContext context) {
    width = context.width();
    return Container(
      margin: EdgeInsets.only(left: 16, bottom: 16, right: 16),
      decoration: boxDecoration(
          radius: 10, showShadow: true, bgColor: context.cardColor),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.transparent,
                ),
                width: width / 6.5,
                height: width / 6.5,
                padding: EdgeInsets.all(10),
                child: Image.asset('images/login/vnat.png'),
              ),
              16.width,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: width * 0.6,
                    child: Text(
                        'Jalan Sultan Salahuddin, Kuala Lumpur, 50480 Kuala Lumpur, Wilayah Persekutuan Kuala Lumpur',
                        style: TextStyle(
                          color: Colors.black,
                        )),
                  ),
                  4.height,
                  Text('LATE', style: boldTextStyle()),
                ],
              )
            ],
          ),
          16.height,
          Text(
            '12-09-2022',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          16.height,
          HistoryListButton(textContent: 'Clock Out', onPressed: () {})
        ],
      ),
    );
  }
}
