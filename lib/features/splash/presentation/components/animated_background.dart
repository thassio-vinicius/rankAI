import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rankai/core/utils/icons.dart';

class AnimatedBackground extends StatefulWidget {
  const AnimatedBackground({super.key});

  @override
  State<AnimatedBackground> createState() => _WidgetState();
}

class _WidgetState extends State<AnimatedBackground> {
  Duration animationDuration = const Duration(seconds: 5);
  final initialDelay = Future.delayed(const Duration(seconds: 1));
  Timer? animationTimer;

  final parallaxWidthPercent = 20;
  final childKey = GlobalKey();

  late Widget childWithKey;
  double? childBaseWidth;
  double? totalAdditionalParallaxWidth;
  double? rightPosition;
  double maxEndPosition = 0;
  double maxStartPosition = 0;

  @override
  void initState() {
    super.initState();
    fetchChildWidth();
    initTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedPositioned(
          right: rightPosition,
          duration: animationDuration,
          child: SizedBox(
            key: childKey,
            width:
                (childBaseWidth != null && totalAdditionalParallaxWidth != null)
                    ? (childBaseWidth! + totalAdditionalParallaxWidth!)
                    : null,
            child: Container(
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height,
              color: Colors.black,
              child: SingleChildScrollView(
                clipBehavior: Clip.none,
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  children: List.generate(
                    35,
                    (index) => Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: index % 2 == 0 ? 40 : 20.0),
                      child: const _AnimatedBackgroundItem(),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  initTimer() async {
    animationTimer?.cancel();
    await initialDelay;
    updateChildPosition();
    animationTimer = Timer.periodic(
      animationDuration,
      (_) => updateChildPosition(),
    );
  }

  updateChildPosition() async {
    if (rightPosition == 0) {
      rightPosition = maxEndPosition;
    } else if (rightPosition == maxEndPosition) {
      rightPosition = maxStartPosition;
    } else if (rightPosition == maxStartPosition) {
      rightPosition = maxEndPosition;
    } else {
      rightPosition = maxEndPosition;
    }
    setState(() {});
  }

  fetchChildWidth() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        final RenderBox renderBoxRed =
            childKey.currentContext?.findRenderObject() as RenderBox;
        final childSize = renderBoxRed.size;
        childBaseWidth = childSize.width;
        initChildPosition();
      },
    );
  }

  initChildPosition() {
    totalAdditionalParallaxWidth = childBaseWidth! * parallaxWidthPercent / 100;
    rightPosition = -totalAdditionalParallaxWidth! / 50;
    maxEndPosition = -childBaseWidth! + totalAdditionalParallaxWidth! * 4.5;
    maxStartPosition = totalAdditionalParallaxWidth!;
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();

    animationTimer?.cancel();
  }
}

class _AnimatedBackgroundItem extends StatefulWidget {
  const _AnimatedBackgroundItem({super.key});

  @override
  State<_AnimatedBackgroundItem> createState() =>
      _AnimatedBackgroundItemState();
}

class _AnimatedBackgroundItemState extends State<_AnimatedBackgroundItem> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      clipBehavior: Clip.none,
      physics: const NeverScrollableScrollPhysics(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          15,
          (index) => Padding(
            padding: const EdgeInsets.only(right: 24, bottom: 24),
            child: Image.asset(
              AssetIcons.chatGpt,
              width: 25,
              height: 25,
              color: Colors.grey.withOpacity(0.5),
            ),
          ),
        ),
      ),
    );
  }
}
