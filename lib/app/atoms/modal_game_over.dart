import 'package:falling_numbers/app/controller/game_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ModalGameOver extends StatelessWidget {
  const ModalGameOver({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      decoration: const BoxDecoration(
        color: Colors.white,
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
            Text('Your score is: 35'),
            SizedBox(height: 18),

            ChangeNotifierProvider(
              create: (context) => GameController(),
              child: ElevatedButton(
                style: ButtonStyle(
                  fixedSize: WidgetStateProperty.all(Size(double.infinity, 20)),
                  side: WidgetStateProperty.all<BorderSide>(
                    BorderSide(color: Colors.white, width: 2),
                  ),
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  backgroundColor: WidgetStateProperty.all<Color>(Colors.teal),
                ),
                onPressed: () {
                  var controller = context.read<GameController>();
                  controller.resetGame();
                },
                child: const Text(
                  'Start New Game',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
