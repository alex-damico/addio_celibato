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

import 'app_theme.dart';

GetIt getIt = GetIt.instance;

void setupLocator() {
  const String envBaseUrl = String.fromEnvironment('BASE_URL');
  String baseUrl;

  if (envBaseUrl.isNotEmpty) {
    baseUrl = envBaseUrl;
  } else {
    baseUrl = '/api';
  }

  final dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 15),
      contentType: 'application/json',
    ),
  );

  if (kDebugMode) {
    dio.interceptors.add(LogInterceptor(
      requestHeader: true,
      requestBody: true,
      responseHeader: false,
      responseBody: true,
      error: true,
    ));
  }

  final restClient = RestClient(dio);

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
      title: 'Addio Celibato',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: HomePage(),
    );
  }
}
