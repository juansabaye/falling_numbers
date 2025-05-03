import 'package:falling_numbers/app/controller/game_controller.dart';
import 'package:falling_numbers/app/enums/music_enum.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    LevelTypeEnum level = context.watch<GameController>().currentlevel;
    return Container(
      height: 70,
      width: 100,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: switch (level) {
            LevelTypeEnum.soft => AssetImage('assets/images/botonSoft.png'),
            LevelTypeEnum.medium => AssetImage('assets/images/botonMedium.png'),
            LevelTypeEnum.doom => AssetImage('assets/images/botonDoom.png'),
            LevelTypeEnum.none => AssetImage('assets/images/botonSoft.png'),
          },
          fit: BoxFit.fill,
        ),
      ),
      child: Center(child: child),
    );
  }
}
