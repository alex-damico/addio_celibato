// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'questions.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionsDto _$QuestionsDtoFromJson(Map<String, dynamic> json) => QuestionsDto(
  content: (json['content'] as List<dynamic>)
      .map((e) => QuestionDto.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$QuestionsDtoToJson(QuestionsDto instance) =>
    <String, dynamic>{'content': instance.content};
