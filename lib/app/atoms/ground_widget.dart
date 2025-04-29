import 'package:flutter/material.dart';

class GroundWidget extends StatelessWidget {
  const GroundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280,
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/ground.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
