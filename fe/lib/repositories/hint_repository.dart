import '../models/hint.dart';
import '../models/hint_create.dart';
import '../models/hints.dart';
import '../network/rest_client.dart';

class HintRepository {
  final RestClient restClient;

  HintRepository({required this.restClient});

  Future<HintDto> getFirstHintByQuestionId(int questionId) =>
      restClient.getFirstHintByQuestionId(questionId);

  Future<HintsDto> getAllForQuestion(int questionId) =>
      restClient.getAllHintsForQuestion(questionId);

  Future<void> setHintUnlocked(int hintId) =>
      restClient.setHintUnlocked(hintId.toString());

  Future<void> resetHintUnlocked(int hintId) =>
      restClient.resetHintUnlocked(hintId.toString());

  Future<int> save(HintCreateDto hint) => restClient.saveHint(hint);

}
