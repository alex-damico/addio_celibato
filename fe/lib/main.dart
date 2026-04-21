import 'package:addio_celibato/injection.dart';
import 'package:addio_celibato/pages/home_page.dart';
import 'package:addio_celibato/utils/logger.dart';
import 'package:flutter/material.dart';

import 'app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  AppLogger.setup();
  await setupLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Addio Celibato',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const HomePage(),
    );
  }
}
