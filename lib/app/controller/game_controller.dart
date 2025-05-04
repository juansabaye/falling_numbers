import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:falling_numbers/app/atoms/modal_game_over.dart';
import 'package:falling_numbers/app/atoms/modal_pause.dart';
import 'package:falling_numbers/app/atoms/number_drop.dart';
import 'package:falling_numbers/app/enums/music_enum.dart';
import 'package:falling_numbers/app/my_app.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GameController extends ChangeNotifier {
  List<NumberDrop> activeDrops = [];
  int dropCount = 1;
  int streak = 0;
  final Random random = Random();
  List<double> vpositions = [];
  bool playingGame = true;
  LevelTypeEnum currentlevel = LevelTypeEnum.none;
  final player = AudioPlayer();

  BuildContext get context => navigatorKey.currentState!.context;
  void addNewDrops() async {
    for (int i = 0; i < dropCount; i++) {
      await Future.delayed(const Duration(milliseconds: 400));
      while (!playingGame) {
        await Future.delayed(const Duration(milliseconds: 100));
      }
      activeDrops.add(
        NumberDrop(
          number: random.nextInt(10),
          hposition:
              random.nextDouble() * (MediaQuery.of(context).size.width - 30),
          speed: random.nextInt(4) + 5,
          key: UniqueKey(),
        ),
      );
      notifyListeners();
      if (dropCount >= 10) {
        playMusic(LevelTypeEnum.doom);
      } else if (dropCount >= 5) {
        playMusic(LevelTypeEnum.medium);
      } else if (dropCount >= 0) {
        playMusic(LevelTypeEnum.soft);
      }
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
    return streak;
  }

  void removeDrops(numberShot) {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (activeDrops.isNotEmpty) {
        int index = activeDrops.indexWhere((drop) => drop.number == numberShot);
        if (index != -1) {
          activeDrops.removeAt(index);
          notifyListeners();
        }
      }
      if (activeDrops.isEmpty) {
        nextLevel();
      }
    });
  }

  void explode(numberShot) {
    if (activeDrops.isNotEmpty) {
      int index = activeDrops.indexWhere((drop) => drop.number == numberShot);
      if (index != -1) {
        activeDrops[index].exploded = true;
        notifyListeners();
        playExplotion(currentlevel);
      }
    }
    if (activeDrops.isEmpty) {
      nextLevel();
    }
  }

  void resetGame() {
    currentlevel = LevelTypeEnum.none;
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

  void finishGame(controller) async {
    activeDrops.clear();
    notifyListeners();
    player.stop();
    showModalBottomSheet(
      context: context,
      isScrollControlled: false,
      isDismissible: false,
      enableDrag: false,
      builder: (BuildContext context) {
        return ModalGameOver(controller: controller);
      },
    );
  }

  void pause(controller) {
    playingGame = false;
    vpositions.clear();
    for (int i = 0; i < activeDrops.length; i++) {
      vpositions.add(activeDrops[i].vposition);
      activeDrops[i].paused = true;
    }
    notifyListeners();
    showModalBottomSheet(
      context: context,
      isScrollControlled: false,
      isDismissible: false,
      enableDrag: false,
      builder: (BuildContext context) {
        return ModalPause(controller: controller);
      },
    );
  }

  void continueGame() {
    playingGame = true;
    for (int i = 0; i < activeDrops.length; i++) {
      if (i < vpositions.length) {
        activeDrops[i].vposition = vpositions[i];
      }
    }
    for (int i = 0; i < activeDrops.length; i++) {
      activeDrops[i].paused = false;
    }
    vpositions.clear();
    notifyListeners();
    Navigator.pop(context);
  }

  Future<void> playMusic(LevelTypeEnum level) async {
    if (currentlevel != level) {
      switch (level) {
        case LevelTypeEnum.soft:
          player.stop();
          await player.play(AssetSource('sounds/musicSoft.mp3'));
          currentlevel = LevelTypeEnum.soft;
          break;
        case LevelTypeEnum.medium:
          player.stop();
          await player.play(AssetSource('sounds/musicMedium.mp3'));
          currentlevel = LevelTypeEnum.medium;
          break;
        case LevelTypeEnum.doom:
          player.stop();
          await player.play(AssetSource('sounds/musicDoom.mp3'));
          currentlevel = LevelTypeEnum.doom;
          break;
        case LevelTypeEnum.none:
          break;
      }
    }
  }

  Future<void> playExplotion(LevelTypeEnum level) async {
    final playerExplotion = AudioPlayer();
    switch (level) {
      case LevelTypeEnum.soft:
        playerExplotion.stop();
        await playerExplotion.play(AssetSource('sounds/explotionSoft.mp3'));
        currentlevel = LevelTypeEnum.soft;
        break;
      case LevelTypeEnum.medium:
        playerExplotion.stop();
        await playerExplotion.play(AssetSource('sounds/explotionMedium.mp3'));
        currentlevel = LevelTypeEnum.medium;
        break;
      case LevelTypeEnum.doom:
        playerExplotion.stop();
        await playerExplotion.play(AssetSource('sounds/explotionDoom.mp3'));
        currentlevel = LevelTypeEnum.doom;
        break;
      case LevelTypeEnum.none:
        break;
    }
  }

  void stopMusic() {
    player.stop();
  }
}
