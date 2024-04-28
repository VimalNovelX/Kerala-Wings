
import 'package:flutter/cupertino.dart';

class CurrentIndexProvider extends  ChangeNotifier{

  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void updateIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }





}