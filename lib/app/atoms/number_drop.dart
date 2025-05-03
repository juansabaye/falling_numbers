import 'package:falling_numbers/app/controller/game_controller.dart';
import 'package:falling_numbers/app/enums/music_enum.dart';
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
  AnimationController? _animationController;
  Animation<double>? _animation;
  bool wasPaused = false;

  @override
  void initState() {
    super.initState();
    initDrop();
  }

  void resumeAnimation() {
    if (wasPaused) {
      final double remainingFraction =
          1.0 - (widget.vposition) / (MediaQuery.of(context).size.height - 320);
      _animation = Tween<double>(
        begin: widget.vposition - ((1 - remainingFraction) * 320 * 1.5),
        end: MediaQuery.of(context).size.height - 320,
      ).animate(_animationController!);
      _animationController!.forward();
      wasPaused = false;
    }
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var controller = context.read<GameController>();
    widget.paused = context.watch<GameController>().activeDrops.any(
      (drop) => drop.key == widget.key && drop.paused,
    );
    LevelTypeEnum level = context.watch<GameController>().currentlevel;
    return AnimatedBuilder(
      animation: _animation ?? AlwaysStoppedAnimation(0),
      builder: (context, child) {
        widget.vposition = _animation?.value ?? 0;

        if (widget.vposition >= MediaQuery.of(context).size.height - 320) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            controller.finishGame(controller);
          });
        }
        if (widget.paused) {
          wasPaused = true;
          _animationController?.stop();
        } else {
          resumeAnimation();
        }
        return Positioned(
          left: widget.hposition,
          top: widget.vposition,
          child: Center(
            child:
                widget.exploded
                    ? Center(
                      child: switch (level) {
                        LevelTypeEnum.soft => Image.asset(
                          'assets/images/explotionSoft.gif',
                          width: 50,
                          height: 50,
                        ),
                        LevelTypeEnum.medium => Image.asset(
                          'assets/images/explotionMedium.gif',
                          width: 50,
                          height: 50,
                        ),
                        LevelTypeEnum.doom => Image.asset(
                          'assets/images/explotionDoom.gif',
                          width: 50,
                          height: 50,
                        ),
                        LevelTypeEnum.none => Image.asset(
                          'assets/images/explotionSoft.gif',
                          width: 50,
                          height: 50,
                        ),
                      },
                    )
                    : Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        image: switch (level) {
                          LevelTypeEnum.soft => DecorationImage(
                            image: AssetImage('assets/images/drop.png'),
                          ),
                          LevelTypeEnum.medium => DecorationImage(
                            image: AssetImage('assets/images/stone.png'),
                          ),
                          LevelTypeEnum.doom => DecorationImage(
                            image: AssetImage('assets/images/demon.gif'),
                          ),
                          LevelTypeEnum.none => DecorationImage(
                            image: AssetImage('assets/images/drop.png'),
                          ),
                        },
                      ),
                      child: Center(
                        child: Text(
                          '${widget.number}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
          ),
        );
      },
    );
  }

  void initDrop() async {
    await Future.delayed(Duration.zero);
    _animationController = AnimationController(
      duration: Duration(seconds: widget.speed),
      vsync: this,
    );
    _animation = Tween<double>(
      begin: 0.0,
      end: MediaQuery.of(context).size.height - 320,
    ).animate(_animationController!);
    _animationController?.forward();
    setState(() {});
  }
}
