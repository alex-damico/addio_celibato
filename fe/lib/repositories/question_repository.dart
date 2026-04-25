import 'package:addio_celibato/models/question.dart';
import 'package:addio_celibato/models/questions.dart';

import '../network/rest_client.dart';

class QuestionRepository {
  final RestClient restClient;

  QuestionRepository({required this.restClient});

  Future<QuestionDto> getFirstPosition() => restClient.getQuestionByFirstPosition();

  Future<QuestionsDto> getAll() => restClient.getAllQuestions();

  Future<void> setResolved(int id) => restClient.setResolved(id.toString());

  Future<void> resetResolved(int id) => restClient.resetResolved(id.toString());
}
