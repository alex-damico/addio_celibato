import '../models/hint.dart';
import '../network/rest_client.dart';

class HintRepository {
  final RestClient restClient;

  HintRepository({required this.restClient});

  Future<HintDto> getFirstHintByQuestionId(int questionId) =>
      restClient.getFirstHintByQuestionId(questionId);

  Future<void> setHintUnlocked(int hintId) =>
      restClient.setHintUnlocked(hintId.toString());
}
