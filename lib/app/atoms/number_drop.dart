import 'package:falling_numbers/app/controller/game_controller.dart';
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
  AnimationController? _controller;
  Animation<double>? _animation;

  @override
  void initState() {
    super.initState();
    initDrop();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation ?? AlwaysStoppedAnimation(0),
      builder: (context, child) {
        double value = _animation?.value ?? 0;
        if (value >= MediaQuery.of(context).size.height - 200) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            var controller = context.read<GameController>();
            controller.finishGame(controller);
          });
        }
        return Positioned(
          left: widget.position,
          top: value,
          child: Center(
            child: Text(
              '${widget.number}',
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        );
      },
    );
  }

  void initDrop() async {
    await Future.delayed(Duration.zero);
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    );
    _animation = Tween<double>(
      begin: -50.0,
      end: MediaQuery.of(context).size.height - 200,
    ).animate(_controller!);
    _controller?.forward();
    setState(() {});
  }
}
