
import 'package:fe/models/hint.dart';
import 'package:fe/models/question.dart';

import '../network/rest_client.dart';

class QuestionRepository {
  final RestClient restClient;

  QuestionRepository({required this.restClient});

  Future<QuestionDto> getFirstPosition() => restClient.getFirstPosition();

  Future<void> setResolved(int id) => restClient.setResolved(id.toString());

  Future<HintDto> getFirstHintByQuestionId(int questionId) => 
      restClient.getFirstHintByQuestionId(questionId);

  Future<void> setHintUnlocked(int hintId) => 
      restClient.setHintUnlocked(hintId.toString());

}