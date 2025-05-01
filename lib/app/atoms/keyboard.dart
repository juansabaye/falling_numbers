import 'package:falling_numbers/app/controller/game_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class KeyBoard extends StatelessWidget {
  const KeyBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10, bottom: 30, left: 20, right: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(5, (index) {
              return ElevatedButton(
                onPressed: () {
                  var controller = context.read<GameController>();
                  controller.removeDrops(index);
                },
                style: ButtonStyle(
                  fixedSize: WidgetStateProperty.all(Size(double.infinity, 60)),
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  side: WidgetStateProperty.all<BorderSide>(
                    BorderSide(color: Colors.white, width: 1),
                  ),

                  backgroundColor: WidgetStateProperty.all<Color>(Colors.teal),
                ),
                child: Text(
                  '$index',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              );
            }),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(5, (index) {
              return ElevatedButton(
                onPressed: () {
                  var controller = context.read<GameController>();
                  controller.removeDrops(index + 5);
                },
                style: ButtonStyle(
                  fixedSize: WidgetStateProperty.all(Size(double.infinity, 60)),
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
                child: Text(
                  '${index + 5}',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
