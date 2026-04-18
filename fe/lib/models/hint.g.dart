// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hint.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HintDto _$HintDtoFromJson(Map<String, dynamic> json) => HintDto(
  id: (json['id'] as num).toInt(),
  position: (json['position'] as num).toInt(),
  content: json['content'] as String,
  isUnlocked: json['isUnlocked'] as bool,
  questionId: (json['questionId'] as num).toInt(),
);

Map<String, dynamic> _$HintDtoToJson(HintDto instance) => <String, dynamic>{
  'id': instance.id,
  'position': instance.position,
  'content': instance.content,
  'isUnlocked': instance.isUnlocked,
  'questionId': instance.questionId,
};
