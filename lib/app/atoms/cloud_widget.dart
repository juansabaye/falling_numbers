import 'package:flutter/material.dart';

class CloudWidget extends StatelessWidget {
  const CloudWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kToolbarHeight + MediaQuery.of(context).padding.top + 30,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/clouds.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
