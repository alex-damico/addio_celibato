
import 'package:dio/dio.dart';
import 'package:fe/models/question.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: 'http://localhost:8080/api')
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET('/questions/firstPosition')
  Future<QuestionDto> getFirstPosition();

}