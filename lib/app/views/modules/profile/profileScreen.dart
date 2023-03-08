import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:vnatpro2/app/controllers/modules/main/AuthController.dart';
import 'package:vnatpro2/app/controllers/modules/main/navbarController.dart';
import 'package:vnatpro2/app/views/auth/login.dart';

import '../../../../main.dart';
import '../../../../main/utils/AppConstant.dart';
import '../../../../main/utils/AppWidget.dart';

class ProfileScreen extends StatelessWidget {
  static const url = '/profile';

  Widget counter(String counter, String counterName) {
    return Column(
      children: <Widget>[
        Text('20',
            style: TextStyle(
                color: Colors.red, fontSize: 18, fontFamily: 'Medium'),
            textAlign: TextAlign.center),
        text(counterName,
            textColor: appStore.textPrimaryColor,
            fontSize: textSizeMedium,
            fontFamily: fontMedium),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var ac = Provider.of<AuthController>(context, listen: false);

    final profileImg = Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      alignment: FractionalOffset.center,
      child: CircleAvatar(
        backgroundImage: AssetImage('images/login/vnat.png'),
        radius: 50,
      ),
    );
    final profileContent = Container(
      margin: EdgeInsets.only(top: 55.0),
      decoration: boxDecoration(
          bgColor: context.scaffoldBackgroundColor,
          radius: 10,
          showShadow: true),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            SizedBox(height: 50),
            text(ac.getName(),
                textColor: appStore.textPrimaryColor,
                fontSize: textSizeNormal,
                fontFamily: fontMedium),
            text(ac.getEmail(),
                textColor: Colors.red,
                fontSize: textSizeMedium,
                fontFamily: fontMedium),
            Padding(
              padding: EdgeInsets.all(16),
              child: Divider(color: Colors.blue, height: 0.5),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                counter("5 Years", 'Work Length'),
                counter("SDT", "Department"),
              ],
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
    return SingleChildScrollView(
      padding: EdgeInsets.only(top: 90, left: 2, right: 2),
      physics: ScrollPhysics(),
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            SizedBox(height: 16),
            Container(
              margin: EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Stack(
                children: <Widget>[profileContent, profileImg],
              ),
            ),
            SizedBox(height: 8),
            Container(
              margin: EdgeInsets.fromLTRB(16, 8, 16, 8),
              decoration: boxDecoration(
                  bgColor: context.scaffoldBackgroundColor,
                  radius: 10,
                  showShadow: true),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 8),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Text('Personal',
                              style: TextStyle(
                                  color: appStore.textPrimaryColor,
                                  fontSize: 18,
                                  fontFamily: 'Bold',
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.left),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
                          child: text('Age',
                              fontSize: textSizeLargeMedium,
                              textColor: appStore.textPrimaryColor,
                              maxLine: 1),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
                          child: text('28',
                              fontSize: textSizeLargeMedium,
                              textColor: appStore.textPrimaryColor,
                              maxLine: 1),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
                      child: Divider(color: Colors.black12, height: 0.5),
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
                          child: text('Contact No',
                              fontSize: textSizeLargeMedium,
                              textColor: appStore.textPrimaryColor,
                              maxLine: 1),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
                          child: text('0176269475',
                              fontSize: textSizeLargeMedium,
                              textColor: appStore.textPrimaryColor,
                              maxLine: 1),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
                      child: Divider(color: Colors.black12, height: 0.5),
                    ),
                    SizedBox(height: 8),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 15, right: 15),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.redAccent),
                ),
                onPressed: () async {
                  await Provider.of<AuthController>(context, listen: false).logout();
                  Provider.of<NavBarController>(context, listen: false)
                      .currentIndex = 0;
                  LoginScreen().launch(context, isNewTask: true);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.exit_to_app),
                    Text('Sign Out'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
