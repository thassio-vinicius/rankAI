import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rankai/core/injector.dart';
import 'package:rankai/core/presentation/routes/my_navigator.dart';
import 'package:rankai/core/presentation/routes/route_names.dart';
import 'package:rankai/core/presentation/widgets/app_logo.dart';
import 'package:rankai/core/presentation/widgets/primary_button.dart';
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
  late Animation<double> _opacity;

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

    _opacity = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
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
              child: FadeTransition(
                opacity: _opacity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    const AppLogo(large: true),
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
                              MyNavigator(context).goNamed(RouteNames.chat),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
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
