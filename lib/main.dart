import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todolist/services/hive_services.dart';

import 'app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  HiveServices.onInit();
  runApp(const ProviderScope(child: AppView()));
}
