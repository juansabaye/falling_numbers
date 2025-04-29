import 'package:flutter/material.dart';

class ScoreProvider extends ChangeNotifier {
  int _currentScore = 0;
  int get currentScore => _currentScore;

  set showScore(int score) {
    _currentScore = score;
    notifyListeners();
  }
}
