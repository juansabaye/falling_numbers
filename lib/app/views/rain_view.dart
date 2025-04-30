import 'package:falling_numbers/app/controller/game_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RainView extends StatefulWidget {
  const RainView({super.key});

  @override
  State<RainView> createState() => RainViewState();
}

class RainViewState extends State<RainView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var controller = context.read<GameController>();
      controller.addNewDrops();
    });
  }

  @override
  Widget build(BuildContext context) {
    var controller = context.watch<GameController>();
    var activeDrops = controller.activeDrops;
    return Stack(children: activeDrops);
  }
}
