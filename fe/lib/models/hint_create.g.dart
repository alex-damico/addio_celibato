// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hint_create.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HintCreateDto _$HintCreateDtoFromJson(Map<String, dynamic> json) =>
    HintCreateDto(
      content: json['content'] as String,
      questionId: (json['questionId'] as num).toInt(),
    );

Map<String, dynamic> _$HintCreateDtoToJson(HintCreateDto instance) =>
    <String, dynamic>{
      'content': instance.content,
      'questionId': instance.questionId,
    };
