import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vnatpro2/app/controllers/modules/main/navbarController.dart';
import 'package:vnatpro2/app/views/modules/attendance/clocks/ClocksScreen.dart';
import 'package:vnatpro2/app/views/modules/attendance/history/historyScreen.dart';
import 'package:vnatpro2/app/views/modules/dashboard/dashboard.dart';
import 'package:vnatpro2/app/views/modules/profile/profileScreen.dart';
import 'package:vnatpro2/app/views/navbar/widgets/bubbleBottomWidget.dart';
import 'package:vnatpro2/main.dart';

class NavbarScreen extends StatefulWidget {
  static const url = '/navbar';
  @override
  State<NavbarScreen> createState() => _NavbarScreenState();
}

class _NavbarScreenState extends State<NavbarScreen> {
  var currentIndex = 0;

  List<Widget> _pages = [
    DashboardScreen(),
    ClocksScreen(),
    HistoryScreen(),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    var nc = Provider.of<NavBarController>(context);
    currentIndex = nc.currentIndex;
    return Scaffold(
      body: _pages[currentIndex],
      bottomNavigationBar: BubbleBottomBar(
        opacity: .2,
        currentIndex: currentIndex,
        backgroundColor: appStore.appBarColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        elevation: 8,
        onTap: (index){
          nc.changeTab(index);
        },
        hasNotch: false,
        hasInk: true,
        inkColor: Colors.red,
        items: <BubbleBottomBarItem>[
          tab(Icons.home_outlined, 'Home'),
          tab(Icons.lock_clock_outlined, 'Clock'),
          tab(Icons.list_alt_outlined, 'History'),
          tab(Icons.person_outline, 'Profile'),
        ],
      ),
    );
  }
}
