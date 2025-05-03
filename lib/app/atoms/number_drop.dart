import 'package:falling_numbers/app/controller/game_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class NumberDrop extends StatefulWidget {
  final int number;
  final double hposition;
  int speed;
  bool exploded;
  bool paused;
  double vposition;

  NumberDrop({
    super.key,
    required this.number,
    required this.hposition,
    this.exploded = false,
    this.speed = 1,
    this.paused = false,
    this.vposition = 0,
  });

  @override
  State<NumberDrop> createState() => _NumberDropState();
}

class _NumberDropState extends State<NumberDrop>
    with SingleTickerProviderStateMixin {
  AnimationController? animationController;
  Animation<double>? _animation;

  @override
  void initState() {
    super.initState();
    initDrop();
  }

  void continueDrop() {
    animationController?.forward();
    setState(() {});
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation ?? AlwaysStoppedAnimation(0),
      builder: (context, child) {
        double vposition = _animation?.value ?? 0;
        if (vposition >= MediaQuery.of(context).size.height - 320) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            var controller = context.read<GameController>();
            controller.finishGame(controller);
          });
        }
        if (widget.paused) {
          animationController?.stop();
        }
        return Positioned(
          left: widget.hposition,
          top: vposition,
          child: Center(
            child:
                widget.exploded
                    ? Text(
                      '💥',
                      style: const TextStyle(color: Colors.white, fontSize: 30),
                    )
                    : Text(
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
    animationController = AnimationController(
      duration: Duration(seconds: widget.speed),
      vsync: this,
    );
    _animation = Tween<double>(
      begin: -50.0,
      end: MediaQuery.of(context).size.height - 320,
    ).animate(animationController!);
    animationController?.forward();
    setState(() {});
  }
}
