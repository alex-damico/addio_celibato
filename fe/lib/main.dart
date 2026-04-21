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
import 'package:shared_preferences/shared_preferences.dart';

import 'package:logging/logging.dart';

import 'app_theme.dart';

GetIt getIt = GetIt.instance;

void setupLocator(SharedPreferences prefs) {
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
  getIt.registerSingleton<RestClient>(restClient);

  getIt.registerLazySingleton<QuestionRepository>(
    () => QuestionRepository(restClient: getIt<RestClient>()),
  );

  getIt.registerLazySingleton<HintRepository>(
    () => HintRepository(restClient: getIt<RestClient>()),
  );

  getIt.registerLazySingleton<TaskRepository>(
    () => TaskRepository(restClient: getIt<RestClient>()),
  );

  getIt.registerSingleton<AdminService>(AdminService(prefs));
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Logger.root.level = Level.ALL; // defaults to Level.INFO
  Logger.root.onRecord.listen((record) {
    debugPrint('${record.level.name}: ${record.time}: ${record.message}');
  });

  final prefs = await SharedPreferences.getInstance();
  setupLocator(prefs);

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
