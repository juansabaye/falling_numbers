import 'dart:math';
import 'package:falling_numbers/app/atoms/modal_game_over.dart';
import 'package:falling_numbers/app/atoms/number_drop.dart';
import 'package:falling_numbers/app/my_app.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GameController extends ChangeNotifier {
  List<NumberDrop> activeDrops = [];
  int dropCount = 1;
  int streak = 0;
  final Random random = Random();

  BuildContext get context => navigatorKey.currentState!.context;
  void addNewDrops() async {
    for (int i = 0; i < dropCount; i++) {
      await Future.delayed(const Duration(milliseconds: 400));
      activeDrops.add(
        NumberDrop(
          number: random.nextInt(10),
          position:
              random.nextDouble() * (MediaQuery.of(context).size.width - 30),
          key: UniqueKey(),
        ),
      );
      notifyListeners();
    }
  }

  Future<bool> addStreak(newStreak) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final streak = sharedPrefs.getInt('streak') ?? 0;
    if (streak < newStreak) {
      return sharedPrefs.setInt('streak', newStreak);
    }
    return false;
  }

  Future<int> getStreak() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final streak = sharedPrefs.getInt('streak') ?? 0;
    print(streak);
    return streak;
  }

  void removeDrops(numberShot) {
    if (activeDrops.isNotEmpty) {
      int index = activeDrops.indexWhere((drop) => drop.number == numberShot);
      if (index != -1) {
        activeDrops.removeAt(index);
      }
    }
    notifyListeners();
    if (activeDrops.isEmpty) {
      nextLevel();
    }
  }

  void resetGame() {
    addStreak(dropCount);
    activeDrops.clear();
    dropCount = 1;
    notifyListeners();
    addNewDrops();
    Navigator.pop(context);
  }

  void nextLevel() {
    dropCount++;
    addNewDrops();
  }

  void finishGame(controller) {
    activeDrops.clear();
    notifyListeners();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return ModalGameOver(controller: controller);
      },
    );
  }
}
