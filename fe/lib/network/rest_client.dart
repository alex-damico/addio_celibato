
import 'package:dio/dio.dart';
import 'package:fe/models/hint.dart';
import 'package:fe/models/question.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: '/api')
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET('/questions/firstPosition')
  Future<QuestionDto> getFirstPosition();

  @PATCH('/questions/{id}/isResolved')
  Future<void> setResolved(@Path() String id);

  @GET('/hints/{questionId}/firstPosition')
  Future<HintDto> getFirstHintByQuestionId(@Path() int questionId);

  @PATCH('/hints/{id}/isUnlocked')
  Future<void> setHintUnlocked(@Path() String id);

}