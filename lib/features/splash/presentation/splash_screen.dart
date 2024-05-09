import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rankai/core/injector.dart';
import 'package:rankai/core/routes/my_navigator.dart';
import 'package:rankai/core/routes/route_names.dart';
import 'package:rankai/core/widgets/my_text.dart';
import 'package:rankai/core/widgets/primary_button.dart';
import 'package:rankai/features/splash/presentation/components/animated_background.dart';
import 'package:rankai/features/splash/presentation/components/animated_rank.dart';
import 'package:rankai/l10n/global_app_localizations.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  double _backgroundOpacity = 0;

  late AnimationController _controller;
  late Animation<Offset> _offset;

  @override
  void initState() {
    Timer(kThemeAnimationDuration, () {
      setState(() {
        _backgroundOpacity = 1;
      });
    });

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _offset = Tween(begin: const Offset(0, 1), end: const Offset(0, 0)).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );

    _controller.addListener(() {
      if (_controller.isCompleted) {
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final intl = sl<GlobalAppLocalizations>().current;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox.expand(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned.fill(
              child: AnimatedOpacity(
                opacity: _backgroundOpacity,
                duration: const Duration(milliseconds: 500),
                child: const AnimatedBackground(),
                onEnd: () {
                  _controller.forward();
                },
              ),
            ),
            Positioned.fill(
              child: SlideTransition(
                position: _offset,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    MyText.xxLarge(
                      intl.appName,
                      style: MyTextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    if (_controller.isCompleted) const AnimatedRank(),
                    const SizedBox(height: 12),
                    const Spacer(),
                    SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: PrimaryButton(
                          text: intl.getStarted,
                          onPressed: () =>
                              MyNavigator(context).goNamed(RouteNames.home),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
