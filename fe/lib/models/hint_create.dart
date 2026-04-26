import 'package:json_annotation/json_annotation.dart';

part 'hint_create.g.dart';

@JsonSerializable()
class HintCreateDto {
  final String content;
  final int questionId;

  HintCreateDto({
    required this.content,
    required this.questionId,
  });

  factory HintCreateDto.fromJson(Map<String, dynamic> json) =>
      _$HintCreateDtoFromJson(json);

  Map<String, dynamic> toJson() => _$HintCreateDtoToJson(this);
}
