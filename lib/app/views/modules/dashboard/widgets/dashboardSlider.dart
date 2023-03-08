import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:vnatpro2/app/views/modules/dashboard/models/models.dart';

import 'package:vnatpro2/app/views/modules/dashboard/datagen/datagen.dart';
import 'sliderWidget.dart';

class ScaffoldSliderWidget extends StatefulWidget {
  @override
  ScaffoldSliderWidgetState createState() => ScaffoldSliderWidgetState();
}

class ScaffoldSliderWidgetState extends State<ScaffoldSliderWidget> {
  var currentIndexPage = 0;
  late List<T2Slider> mSliderList;

  @override
  void initState() {
    super.initState();
    mSliderList = getSliders();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    final Size cardSize = Size(width, width / 1.8);
    return Column(
      children: <Widget>[
        T2CarouselSlider(
          viewportFraction: 0.8,
          height: cardSize.height,
          enlargeCenterPage: true,
          scrollDirection: Axis.horizontal,
          items: mSliderList.map((slider) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: cardSize.height,
                  child: Stack(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: new BorderRadius.circular(12.0),
                        child: Image.asset(
                          'images/login/vnat.png',
                          width: MediaQuery.of(context).size.width,
                          height: cardSize.height,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(1.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(slider.title,
                                style: boldTextStyle(color: white, size: 20)),
                            SizedBox(height: 16),
                            Text(slider.subTitle,
                                style: primaryTextStyle(color: white, size: 16),
                                textAlign: TextAlign.center),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            );
          }).toList(),
          onPageChanged: (index) {
            setState(() {
              currentIndexPage = index;
            });
          },
        ),
        SizedBox(
          height: 16,
        ),
      ],
    );
  }
}
