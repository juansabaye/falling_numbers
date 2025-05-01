import 'package:falling_numbers/app/controller/game_controller.dart';
import 'package:flutter/material.dart';

class ModalGameOver extends StatelessWidget {
  const ModalGameOver({super.key, required this.controller});
  final GameController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/background.png'),
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
                'Your score is:',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 8),
            Text(
              '${controller.dropCount}',
              style: TextStyle(
                fontSize: 54,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              'Points',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            FutureBuilder(
              future: controller.getStreak(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Current streak:  ',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      SizedBox(
                        height: 16,
                        width: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    ],
                  );
                }
                if (!snapshot.hasData || snapshot.data == 0) {
                  return Text('Current streak: 0');
                }
                return Text(
                  'Current streak: ${snapshot.data}',
                  style: TextStyle(fontSize: 14, color: Colors.white),
                );
              },
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
                controller.resetGame();
              },
              child: const Text(
                'Start New Game',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
