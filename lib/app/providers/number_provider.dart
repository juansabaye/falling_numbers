import 'package:flutter/material.dart';

class NumberProvider extends ChangeNotifier {
  int _currentNumber = 0;
  int get currentNumber => _currentNumber;

  set shotNumber(int number) {
    _currentNumber = number;
    notifyListeners();
  }
}
