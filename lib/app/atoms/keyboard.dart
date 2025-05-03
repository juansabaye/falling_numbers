import 'package:falling_numbers/app/atoms/button_widget.dart';
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
              return InkWell(
                onTap: () {
                  var controller = context.read<GameController>();
                  controller.explode(index + 1);
                  controller.removeDrops(index + 1);
                },
                child: ButtonWidget(
                  child: Text(
                    '${index + 1}',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(3, (index) {
              return InkWell(
                onTap: () {
                  var controller = context.read<GameController>();
                  controller.explode(index + 4);
                  controller.removeDrops(index + 4);
                },
                child: ButtonWidget(
                  child: Text(
                    '${index + 4}',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(3, (index) {
              return InkWell(
                onTap: () {
                  var controller = context.read<GameController>();
                  controller.explode(index + 7);
                  controller.removeDrops(index + 7);
                },
                child: ButtonWidget(
                  child: Text(
                    '${index + 7}',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: ButtonWidget(
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.white,
                    size: 21,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  var controller = context.read<GameController>();
                  controller.explode(0);

                  controller.removeDrops(0);
                },
                child: ButtonWidget(
                  child: Text(
                    '${0}',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  var controller = context.read<GameController>();
                  controller.pause(controller);
                },
                child: ButtonWidget(
                  child: Icon(Icons.pause, color: Colors.white, size: 24),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
