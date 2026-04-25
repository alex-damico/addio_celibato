
import 'package:addio_celibato/models/question.dart';
import 'package:json_annotation/json_annotation.dart';

part 'questions.g.dart';

@JsonSerializable()
class QuestionsDto {
  final List<QuestionDto> content;

  QuestionsDto({required this.content});

  factory QuestionsDto.fromJson(Map<String, dynamic> json) =>
      _$QuestionsDtoFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionsDtoToJson(this);
}