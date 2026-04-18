import 'package:json_annotation/json_annotation.dart';

part 'hint.g.dart';

@JsonSerializable()
class HintDto {
  final int id;
  final int position;
  final String content;
  final bool isUnlocked;
  final int questionId;

  HintDto({
    required this.id,
    required this.position,
    required this.content,
    required this.isUnlocked,
    required this.questionId,
  });

  factory HintDto.fromJson(Map<String, dynamic> json) =>
      _$HintDtoFromJson(json);

  Map<String, dynamic> toJson() => _$HintDtoToJson(this);
}
