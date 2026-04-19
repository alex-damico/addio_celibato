import 'package:dio/dio.dart';
import 'package:addio_celibato/network/rest_client.dart';
import 'package:addio_celibato/pages/home_page.dart';
import 'package:addio_celibato/repositories/hint_repository.dart';
import 'package:addio_celibato/repositories/question_repository.dart';
import 'package:addio_celibato/repositories/task_repository.dart';
import 'package:addio_celibato/service/admin_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:logging/logging.dart';

import 'app_colors.dart';

GetIt getIt = GetIt.instance;

void setupLocator() {
  final dio = Dio();

  String baseUrl = '/api';
  if (kDebugMode) {
    if (kIsWeb) {
      baseUrl = 'http://localhost:8080/api';
    } else {
      //baseUrl = 'http://10.0.2.2:8080/api';
      baseUrl = 'http://192.168.178.114:8080/api';
    }
  }

  final restClient = RestClient(dio, baseUrl: baseUrl);

  getIt.registerLazySingleton<QuestionRepository>(
    () => QuestionRepository(restClient: restClient),
  );

  getIt.registerLazySingleton<HintRepository>(
    () => HintRepository(restClient: restClient),
  );

  getIt.registerLazySingleton<TaskRepository>(
    () => TaskRepository(restClient: restClient),
  );

  getIt.registerSingleton<AdminService>(AdminService(), signalsReady: true);
}

void main() {
  Logger.root.level = Level.ALL; // defaults to Level.INFO
  Logger.root.onRecord.listen((record) {
    debugPrint('${record.level.name}: ${record.time}: ${record.message}');
  });
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Addio Celibato Ale',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.background,

        colorScheme: const ColorScheme.dark(
          primary: AppColors.primary,
          onPrimary: AppColors.onPrimaryFixed,
          primaryContainer: AppColors.primaryContainer,
          secondary: AppColors.secondary,
          surface: AppColors.background,
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryContainer,
            foregroundColor: AppColors.onPrimaryFixed,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
          ),
        ),

        textTheme: TextTheme(
          displayLarge: TextStyle(
            color: AppColors.text,
            fontWeight: FontWeight.bold,
            fontSize: 20,
            letterSpacing: 2,
          ),

          labelSmall: TextStyle(
            color: AppColors.text,
            fontSize: 10,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),

          labelMedium: TextStyle(
            color: AppColors.text,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),

          labelLarge: TextStyle(
            color: AppColors.text,
            fontSize: 56,
            height: 0.9,
            fontWeight: FontWeight.w900,
            letterSpacing: -2,
          ),

          bodyMedium: TextStyle(
            color: AppColors.text,
            fontSize: 20,
            height: 1.5,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: HomePage(),
    );
  }
}
