import 'package:fe/models/question.dart';

import '../network/rest_client.dart';

class QuestionRepository {
  final RestClient restClient;

  QuestionRepository({required this.restClient});

  Future<QuestionDto> getFirstPosition() => restClient.getFirstPosition();

  Future<void> setResolved(int id) => restClient.setResolved(id.toString());
}
