import 'dart:math';
import 'package:falling_numbers/app/atoms/modal_game_over.dart';
import 'package:falling_numbers/app/atoms/number_drop.dart';
import 'package:falling_numbers/app/my_app.dart';
import 'package:flutter/material.dart';

class GameController extends ChangeNotifier {
  List<NumberDrop> activeDrops = [];
  int dropCount = 1;
  final Random random = Random();

  BuildContext get context => navigatorKey.currentState!.context;
  void addNewDrops() async {
    for (int i = 0; i < dropCount; i++) {
      await Future.delayed(const Duration(milliseconds: 100));
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
    activeDrops.clear();
    dropCount = 1;
    notifyListeners();
    Navigator.pop(context);
  }

  void nextLevel() {
    dropCount++;
    addNewDrops();
  }

  void finishGame() {
    dropCount = 1;
    activeDrops.clear();
    notifyListeners();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return ModalGameOver();
      },
    );
  }
}
