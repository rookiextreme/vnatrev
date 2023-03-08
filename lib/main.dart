import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:vnatpro2/app/controllers/modules/main/AuthController.dart';
import 'package:vnatpro2/app/controllers/modules/main/LocationController.dart';
import 'package:vnatpro2/app/controllers/modules/main/navbarController.dart';
import 'package:vnatpro2/app/views/auth/login.dart';
import 'package:vnatpro2/app/views/modules/attendance/clocks/ClocksScreen.dart';
import 'package:vnatpro2/app/views/modules/attendance/history/historyScreen.dart';
import 'package:vnatpro2/app/views/modules/dashboard/dashboard.dart';
import 'package:vnatpro2/app/views/modules/profile/profileScreen.dart';
import 'package:vnatpro2/app/views/navbar/navbarscreen.dart';
import 'package:vnatpro2/app/views/splash/SplashScreen.dart';
import 'package:vnatpro2/main/store/AppStore.dart';

AppStore appStore = AppStore();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => LocationController(),
        ),
        ChangeNotifierProvider(
          create: (_) => NavBarController(),
        ),
        ChangeNotifierProvider(
          create: (_) => AuthController(),
        )
      ],
      child: MaterialApp(
        initialRoute: SplashScreen.url,
        routes: {
          SplashScreen.url: (context) => SplashScreen(),
          LoginScreen.url: (context) => LoginScreen(),
          DashboardScreen.url: (context) => DashboardScreen(),
          ClocksScreen.url: (context) => ClocksScreen(),
          HistoryScreen.url: (context) => HistoryScreen(),
          NavbarScreen.url: (context) => NavbarScreen(),
          ProfileScreen.url: (context) => ProfileScreen()
        },
      ),
    );
  }
}
