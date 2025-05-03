import 'package:falling_numbers/app/controller/game_controller.dart';
import 'package:falling_numbers/app/enums/music_enum.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CloudWidget extends StatelessWidget {
  const CloudWidget({super.key});

  @override
  Widget build(BuildContext context) {
    LevelTypeEnum level = context.watch<GameController>().currentlevel;

    return Container(
      height: 396,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: switch (level) {
            LevelTypeEnum.soft => AssetImage('assets/images/cloudsSoft.png'),
            LevelTypeEnum.medium => AssetImage(
              'assets/images/cloudsMedium.png',
            ),
            LevelTypeEnum.doom => AssetImage('assets/images/cloudsDoom.png'),
            LevelTypeEnum.none => AssetImage('assets/images/cloudsSoft.png'),
          },
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }
}
