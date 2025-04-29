import 'package:falling_numbers/app/atoms/number_drop.dart';
import 'package:falling_numbers/app/providers/number_provider.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:provider/provider.dart';

class RainView extends StatefulWidget {
  const RainView({super.key});

  @override
  State<RainView> createState() => RainViewState();
}

class RainViewState extends State<RainView> {
  List<NumberDrop> activeDrops = [];
  int dropCount = 1;
  final Random random = Random();
  late final int numberShot;

  void addNewDrops() {
    setState(() {
      for (int i = 0; i < dropCount; i++) {
        //context.read<ScoreProvider>().showScore = dropCount;
        activeDrops.add(
          NumberDrop(
            number: random.nextInt(10),
            position:
                random.nextDouble() * (MediaQuery.of(context).size.width - 30),
          ),
        );
      }
    });
    print(activeDrops.map((drop) => drop.number).toList());
  }

  void removeDrops() {
    setState(() {
      numberShot =
          Provider.of<NumberProvider>(context, listen: false).currentNumber;
      if (activeDrops.isNotEmpty) {
        activeDrops.removeWhere((drop) => drop.number == numberShot);
        dropCount++;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      addNewDrops();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: activeDrops);
  }
}
