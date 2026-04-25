import 'package:addio_celibato/models/question_create.dart';
import 'package:dio/dio.dart';
import 'package:addio_celibato/models/hint.dart';
import 'package:addio_celibato/models/question.dart';
import 'package:addio_celibato/models/questions.dart';
import 'package:addio_celibato/models/task_create.dart';
import 'package:addio_celibato/models/tasks.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

import '../models/task.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: '/api')
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET('/questions/firstPosition')
  Future<QuestionDto> getQuestionByFirstPosition();

  @GET('/questions/?page=0&size=50&sort=id')
  Future<QuestionsDto> getAllQuestions();

  @PATCH('/questions/{id}/isResolved')
  Future<void> setResolved(@Path() String id);

  @PATCH('/questions/{id}/resetIsResolved')
  Future<void> resetResolved(@Path() String id);

  @POST('/questions/')
  Future<int> saveQuestion(@Body() QuestionCreateDto question);

  @GET('/hints/{questionId}/firstPosition')
  Future<HintDto> getFirstHintByQuestionId(@Path() int questionId);

  @PATCH('/hints/{id}/isUnlocked')
  Future<void> setHintUnlocked(@Path() String id);

  @GET('/tasks/?page=0&size=50')
  Future<TasksDto> getAllTasks();

  @POST('/tasks/{id}/send')
  Future<TaskDto> sendTask(@Path() int id);

  @POST('/tasks/')
  Future<int> saveTask(@Body() TaskCreateDto task);
}
