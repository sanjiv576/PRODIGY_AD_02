import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'Hieasf',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              height: 12,
            ),
            ElevatedButton(onPressed: () {}, child: const Text('data'))
          ],
        ),
      ),
    );
  }
}
