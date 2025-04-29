import 'package:falling_numbers/app/providers/score_provider.dart';
import 'package:falling_numbers/app/views/rain_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NumberDrop extends StatefulWidget {
  final int number;
  final double position;

  const NumberDrop({super.key, required this.number, required this.position});

  @override
  State<NumberDrop> createState() => _NumberDropState();
}

class _NumberDropState extends State<NumberDrop>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    );
    _animation = Tween<double>(begin: -50.0, end: 555).animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ScoreProvider(),
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          if (_animation.value >= 555) {
            _controller.stop();
            WidgetsBinding.instance.addPostFrameCallback((_) {
              showNewModalBottomSheet(context);
            });
          }
          return Positioned(
            left: widget.position,
            top: _animation.value,
            child: Center(
              child: Text(
                '${widget.number}',
                style: const TextStyle(color: Colors.black, fontSize: 18),
              ),
            ),
          );
        },
      ),
    );
  }

  void showNewModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return menuGameOver(context);
      },
    );
  }

  Container menuGameOver(BuildContext context) {
    //final score = context.watch<ScoreProvider>().currentScore;
    return Container(
      height: 400,
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('Your score is: 35'),
            SizedBox(height: 18),

            ElevatedButton(
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
                Navigator.pop(context);
                final rain = RainViewState();
                rain.addNewDrops();
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
