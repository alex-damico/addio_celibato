// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskDto _$TaskDtoFromJson(Map<String, dynamic> json) => TaskDto(
  id: (json['id'] as num).toInt(),
  content: json['content'] as String,
);

Map<String, dynamic> _$TaskDtoToJson(TaskDto instance) => <String, dynamic>{
  'id': instance.id,
  'content': instance.content,
};
