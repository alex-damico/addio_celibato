import 'package:json_annotation/json_annotation.dart';

part 'question.g.dart';

@JsonSerializable()
class QuestionDto {
  final int id;
  final int position;
  final String? intro;
  final String content;
  final String correctAnswer;
  final bool isResolved;

  QuestionDto({
    required this.id,
    required this.position,
    this.intro,
    required this.content,
    required this.correctAnswer,
    required this.isResolved,
  });

  factory QuestionDto.fromJson(Map<String, dynamic> json) =>
      _$QuestionDtoFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionDtoToJson(this);
}
