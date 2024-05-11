import 'package:flutter/material.dart';

class JumpingDotsProgressIndicator extends StatefulWidget {
  final int numberOfDots;
  final double fontSize;
  final double dotSpacing;
  final Color color;
  final int milliseconds;

  const JumpingDotsProgressIndicator({
    super.key,
    this.numberOfDots = 3,
    this.fontSize = 10.0,
    this.color = Colors.black,
    this.dotSpacing = 0.0,
    this.milliseconds = 250,
  });

  @override
  State<JumpingDotsProgressIndicator> createState() =>
      _JumpingDotsProgressIndicatorState();
}

class _JumpingDotsProgressIndicatorState
    extends State<JumpingDotsProgressIndicator> with TickerProviderStateMixin {
  List<AnimationController> controllers = [];
  List<Animation<double>> animations = [];
  List<Widget> dots = [];

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startAnimations();
  }

  void _initializeAnimations() {
    for (int i = 0; i < widget.numberOfDots; i++) {
      final controller = AnimationController(
        duration: Duration(milliseconds: widget.milliseconds),
        vsync: this,
      );
      final animation = Tween(begin: 0.0, end: 8.0).animate(controller);
      animations.add(animation);
      controllers.add(controller);
    }
  }

  void _startAnimations() {
    for (int i = 0; i < widget.numberOfDots; i++) {
      controllers[i].addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controllers[i].reverse();
          if (i < widget.numberOfDots - 1) {
            controllers[i + 1].forward();
          } else {
            controllers[0].forward();
          }
        } else if (status == AnimationStatus.dismissed) {
          controllers[i].forward();
        }
      });
      dots.add(
        Padding(
          padding: EdgeInsets.only(right: widget.dotSpacing),
          child: _JumpingDot(
            animation: animations[i],
            fontSize: widget.fontSize,
            color: widget.color,
          ),
        ),
      );
    }
    controllers[0].forward();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: dots,
      ),
    );
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }
}

class _JumpingDot extends AnimatedWidget {
  final Color color;
  final double fontSize;

  const _JumpingDot({
    required Animation<double> animation,
    required this.color,
    required this.fontSize,
  }) : super(listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable as Animation<double>;
    return SizedBox(
      height: animation.value,
      child: Text(
        '.',
        style: TextStyle(color: color, fontSize: fontSize),
      ),
    );
  }
}
