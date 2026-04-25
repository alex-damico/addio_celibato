import 'package:json_annotation/json_annotation.dart';

part 'question_create.g.dart';

@JsonSerializable()
class QuestionCreateDto {
  final String? intro;
  final String content;
  final String correctAnswer;

  QuestionCreateDto({
    this.intro,
    required this.content,
    required this.correctAnswer,
  });

  factory QuestionCreateDto.fromJson(Map<String, dynamic> json) =>
      _$QuestionCreateDtoFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionCreateDtoToJson(this);
}
