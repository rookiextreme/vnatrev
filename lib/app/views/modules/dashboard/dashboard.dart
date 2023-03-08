import 'package:analog_clock/analog_clock.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:vnatpro2/app/views/modules/dashboard/widgets/analogWidget.dart';
import 'package:vnatpro2/main.dart';

import 'datagen/datagen.dart';
import 'models/models.dart';

class DashboardScreen extends StatefulWidget {
  static const url = 'Dashboard';

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool passwordVisible = false;

  bool isRemember = false;

  var currentIndexPage = 0;

  late List<T2Favourite> mFavouriteList;

  List<T2Slider>? mSliderList;

  var currentIndex = 0;

  @override
  void initState() {
    super.initState();
    passwordVisible = false;
    mFavouriteList = getFavourites();
    mSliderList = getSliders();
  }

  void changePage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Stack(
        children: <Widget>[
          SingleChildScrollView(
            padding: EdgeInsets.only(top: 40),
            physics: ScrollPhysics(),
            child: Column(
              children: <Widget>[
                AnalogWidget(),
                SizedBox(height: height / 25),
                Padding(
                  padding: EdgeInsets.only(left: 16, right: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Attendance Today',
                          style: boldTextStyle(
                              color: appStore.textPrimaryColor, size: 20)),
                      GestureDetector(
                        child: Text('Show All',
                            style: boldTextStyle(
                                size: 16, color: appStore.textPrimaryColor)),
                        onTap: () {},
                      )
                    ],
                  ),
                ),
                10.height,
                Padding(
                  padding: EdgeInsets.only(left: 16, right: 16),
                  child: ListView.builder(
                    // physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (context, position) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 16),
                        child: Row(
                          children: <Widget>[
                            Image.asset(
                              'images/login/vnat.png',
                              width: width / 3,
                              height: width / 2.4,
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: Container(
                                width: width - (width / 3) - 16,
                                height: 100,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(mFavouriteList[position].name,
                                        style: boldTextStyle(
                                            color: appStore.textPrimaryColor,
                                            size: 16),
                                        maxLines: 2),
                                    SizedBox(height: 8),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Icon(Icons.timelapse,
                                                size: 16,
                                                color: appStore
                                                    .textSecondaryColor),
                                            SizedBox(width: 2),
                                            Text(
                                                mFavouriteList[position]
                                                    .duration,
                                                style: secondaryTextStyle()),
                                          ],
                                        ),
                                        GestureDetector(
                                          child: Row(
                                            children: <Widget>[
                                              Text('Lets Read',
                                                  style: secondaryTextStyle()),
                                              Icon(Icons.keyboard_arrow_right,
                                                  size: 16,
                                                  color: appStore
                                                      .textSecondaryColor),
                                            ],
                                          ),
                                          onTap: () {},
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 10)
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                    itemCount: mFavouriteList.length,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
