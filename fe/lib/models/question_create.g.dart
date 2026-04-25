// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_create.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionCreateDto _$QuestionCreateDtoFromJson(Map<String, dynamic> json) =>
    QuestionCreateDto(
      intro: json['intro'] as String?,
      content: json['content'] as String,
      correctAnswer: json['correctAnswer'] as String,
    );

Map<String, dynamic> _$QuestionCreateDtoToJson(QuestionCreateDto instance) =>
    <String, dynamic>{
      'intro': instance.intro,
      'content': instance.content,
      'correctAnswer': instance.correctAnswer,
    };
