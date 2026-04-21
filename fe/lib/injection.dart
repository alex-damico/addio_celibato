import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'network/rest_client.dart';
import 'repositories/hint_repository.dart';
import 'repositories/question_repository.dart';
import 'repositories/task_repository.dart';
import 'service/admin_service.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  final prefs = await SharedPreferences.getInstance();
  
  const String envBaseUrl = String.fromEnvironment('BASE_URL');
  final String baseUrl = envBaseUrl.isNotEmpty ? envBaseUrl : '/api';

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
  getIt.registerSingleton<AdminService>(AdminService(prefs));

  getIt.registerLazySingleton<QuestionRepository>(
    () => QuestionRepository(restClient: getIt<RestClient>()),
  );

  getIt.registerLazySingleton<HintRepository>(
    () => HintRepository(restClient: getIt<RestClient>()),
  );

  getIt.registerLazySingleton<TaskRepository>(
    () => TaskRepository(restClient: getIt<RestClient>()),
  );
}
