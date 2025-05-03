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
            children: List.generate(3, (index) {
              return ElevatedButton(
                onPressed: () {
                  var controller = context.read<GameController>();
                  controller.explode(index + 1);
                  Future.delayed(const Duration(milliseconds: 100), () {
                    controller.removeDrops(index + 1);
                  });
                },
                style: ButtonStyle(
                  fixedSize: WidgetStateProperty.all(Size(100, 60)),
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
                  '${index + 1}',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              );
            }),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(3, (index) {
              return ElevatedButton(
                onPressed: () {
                  var controller = context.read<GameController>();
                  controller.explode(index + 4);
                  Future.delayed(const Duration(milliseconds: 100), () {
                    controller.removeDrops(index + 4);
                  });
                },
                style: ButtonStyle(
                  fixedSize: WidgetStateProperty.all(Size(100, 60)),
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
                  '${index + 4}',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              );
            }),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(3, (index) {
              return ElevatedButton(
                onPressed: () {
                  var controller = context.read<GameController>();
                  controller.explode(index + 7);
                  Future.delayed(const Duration(milliseconds: 100), () {
                    controller.removeDrops(index + 7);
                  });
                },
                style: ButtonStyle(
                  fixedSize: WidgetStateProperty.all(Size(100, 60)),
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
                  '${index + 7}',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              );
            }),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,

            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ButtonStyle(
                  fixedSize: WidgetStateProperty.all(Size(100, 60)),
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
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.white,
                  size: 21,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  var controller = context.read<GameController>();
                  controller.explode(0);
                  Future.delayed(const Duration(milliseconds: 100), () {
                    controller.removeDrops(0);
                  });
                },
                style: ButtonStyle(
                  fixedSize: WidgetStateProperty.all(Size(100, 60)),
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
                  '${0}',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  var controller = context.read<GameController>();
                  controller.pause(controller);
                },
                style: ButtonStyle(
                  fixedSize: WidgetStateProperty.all(Size(100, 60)),
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
                child: Icon(Icons.pause, color: Colors.white, size: 24),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
