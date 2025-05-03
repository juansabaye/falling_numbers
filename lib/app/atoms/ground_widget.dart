import 'package:falling_numbers/app/controller/game_controller.dart';
import 'package:falling_numbers/app/enums/music_enum.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GroundWidget extends StatelessWidget {
  const GroundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    LevelTypeEnum level = context.watch<GameController>().currentlevel;
    return Container(
      height: 320,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: switch (level) {
            LevelTypeEnum.soft => AssetImage('assets/images/groundSoft.png'),
            LevelTypeEnum.medium => AssetImage(
              'assets/images/groundMedium.png',
            ),
            LevelTypeEnum.doom => AssetImage('assets/images/groundDoom.png'),
            LevelTypeEnum.none => AssetImage('assets/images/groundSoft.png'),
          },
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
