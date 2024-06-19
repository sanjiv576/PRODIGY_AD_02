import 'package:flutter/material.dart';
import '../router/app_routes.dart';

class IntroView extends StatelessWidget {
  const IntroView({super.key});

  final verticalGap = const SizedBox(height: 16);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Image(
              fit: BoxFit.cover,
              image: AssetImage(
                'assets/images/todolist_logo.png',
              ),
            ),
            verticalGap,
            Text(
              'Write what you need to do and remember it.',
              style: Theme.of(context).textTheme.labelSmall,
              textAlign: TextAlign.center,
            ),
            verticalGap,
            ElevatedButton(
              onPressed: () =>
                  Navigator.pushNamed(context, AppRoutes.homeRoute),
              child: Text(
                'Continue',
                style: Theme.of(context)
                    .textTheme
                    .labelSmall!
                    .copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
