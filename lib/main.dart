import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'services/hive_services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveServices.onInit();
  runApp(const ProviderScope(child: AppView()));
}
