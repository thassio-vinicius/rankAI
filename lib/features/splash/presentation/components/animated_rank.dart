import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rankai/core/utils/colors.dart';
import 'package:rankai/core/utils/icons.dart';

class AnimatedRank extends StatefulWidget {
  const AnimatedRank({super.key});

  @override
  State<AnimatedRank> createState() => _AnimatedRankState();
}

class _AnimatedRankState extends State<AnimatedRank> {
  bool _triggerAnimation = false;

  @override
  void initState() {
    Timer(kThemeAnimationDuration, () {
      setState(() {
        _triggerAnimation = true;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _AnimatedRankItem(height: _triggerAnimation ? 10 : 0),
        const SizedBox(width: 6),
        _AnimatedRankItem(height: _triggerAnimation ? 20 : 0),
        _AnimatedRankItem(
          height: _triggerAnimation ? 30 : 0,
          hasTrophy: _triggerAnimation,
        ),
      ],
    );
  }
}

class _AnimatedRankItem extends StatefulWidget {
  final bool hasTrophy;
  final double height;
  const _AnimatedRankItem({
    this.hasTrophy = false,
    required this.height,
  });

  @override
  State<_AnimatedRankItem> createState() => _AnimatedRankItemState();
}

class _AnimatedRankItemState extends State<_AnimatedRankItem> {
  double _opacity = 0;

  @override
  void initState() {
    Timer(const Duration(milliseconds: 500), () {
      setState(() {
        _opacity = 1;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.hasTrophy)
          AnimatedOpacity(
            duration: kThemeAnimationDuration,
            opacity: _opacity,
            child: Image.asset(
              AssetIcons.trophy,
              width: 20,
              height: 20,
              fit: BoxFit.scaleDown,
              color: AppColors.primaryBubble,
            ),
          ),
        const SizedBox(height: 6),
        AnimatedContainer(
          duration: kThemeAnimationDuration,
          decoration: const BoxDecoration(
            color: AppColors.primaryBubble,
            borderRadius: BorderRadius.vertical(top: Radius.circular(2)),
          ),
          height: widget.height,
          width: 10,
        ),
      ],
    );
  }
}
