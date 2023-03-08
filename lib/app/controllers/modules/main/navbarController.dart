import 'package:flutter/foundation.dart';

class NavBarController extends ChangeNotifier{
  int currentIndex = 0;

  void changeTab(int index){
    currentIndex = index;
    notifyListeners();
  }
}