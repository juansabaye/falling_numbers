import 'package:falling_numbers/app/controller/game_controller.dart';
import 'package:falling_numbers/app/enums/music_enum.dart';
import 'package:flutter/material.dart';

class ModalPause extends StatelessWidget {
  const ModalPause({super.key, required this.controller});
  final GameController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: switch (controller.currentlevel) {
            LevelTypeEnum.soft => AssetImage('assets/images/groundSoft.png'),
            LevelTypeEnum.medium => AssetImage(
              'assets/images/groundMedium.png',
            ),
            LevelTypeEnum.doom => AssetImage('assets/images/groundDoom.png'),
            LevelTypeEnum.none => AssetImage('assets/images/groundSoft.png'),
          },
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
              ),

              child: Text(
                'The game is paused',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 8),

            Text(
              'Waiting for you to continue',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Current streak: ${controller.dropCount}',
              style: TextStyle(fontSize: 14, color: Colors.white),
            ),
            SizedBox(height: 28),
            ElevatedButton(
              style: ButtonStyle(
                fixedSize: WidgetStateProperty.all(Size(double.infinity, 40)),
                side: WidgetStateProperty.all<BorderSide>(
                  BorderSide(color: Colors.white, width: 1),
                ),
                shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                backgroundColor: WidgetStateProperty.all<Color>(Colors.teal),
              ),
              onPressed: () {
                controller.continueGame();
              },
              child: const Text(
                'Continue',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
