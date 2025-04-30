import 'package:falling_numbers/app/atoms/cloud_widget.dart';
import 'package:falling_numbers/app/atoms/ground_widget.dart';
import 'package:falling_numbers/app/atoms/keyboard.dart';
import 'package:falling_numbers/app/controller/game_controller.dart';
import 'package:falling_numbers/app/views/rain_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => GameController(),
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
              top: kToolbarHeight + MediaQuery.of(context).padding.top,
              left: 0,
              right: 0,
              bottom: 200,
              child: RainView(),
            ),
            Positioned(top: 0, left: 0, right: 0, child: CloudWidget()),
            Positioned(left: 0, right: 0, bottom: 0, child: GroundWidget()),
            Positioned(bottom: 0, left: 0, right: 0, child: KeyBoard()),
          ],
        ),
      ),
    );
  }
}
