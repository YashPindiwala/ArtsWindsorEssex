import 'package:flutter/material.dart';

class NavigationProvider extends ChangeNotifier{
  int _currentIndex = 2;
  int get currentIndex => _currentIndex;

  navigate(int index){
    _currentIndex = index;
    notifyListeners();
  }
}