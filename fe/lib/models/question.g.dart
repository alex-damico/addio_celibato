// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionDto _$QuestionDtoFromJson(Map<String, dynamic> json) => QuestionDto(
  id: (json['id'] as num).toInt(),
  position: (json['position'] as num).toInt(),
  intro: json['intro'] as String?,
  content: json['content'] as String,
  correctAnswer: json['correctAnswer'] as String,
  isResolved: json['isResolved'] as bool,
);

Map<String, dynamic> _$QuestionDtoToJson(QuestionDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'position': instance.position,
      'intro': instance.intro,
      'content': instance.content,
      'correctAnswer': instance.correctAnswer,
      'isResolved': instance.isResolved,
    };
