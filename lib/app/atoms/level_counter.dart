import 'package:falling_numbers/app/controller/game_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LevelCounter extends StatelessWidget {
  const LevelCounter({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<GameController>();
    return Text(
      'Level: ${controller.dropCount}',
      style: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
