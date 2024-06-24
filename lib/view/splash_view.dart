import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

import '../router/app_routes.dart';
import '../shared_prefs/user_shared_prefs.dart';

class SplashView extends ConsumerStatefulWidget {
  const SplashView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView> {
  void _launchApp() async {
    UserSharedPrefs userSharedPrefs = UserSharedPrefs();

    bool? isAppLauchValue = await userSharedPrefs.isAppLaunch();

    if (isAppLauchValue != null) {
      Navigator.popAndPushNamed(context, AppRoutes.homeRoute);
    } else {
      Navigator.popAndPushNamed(context, AppRoutes.introRoute);
    }
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      _launchApp();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LottieBuilder.asset('assets/animation/animation.json'),
                const SizedBox(height: 16),
                Text(
                  'Developed by: Sanjiv Shrestha',
                  style: Theme.of(context).textTheme.bodyLarge,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
