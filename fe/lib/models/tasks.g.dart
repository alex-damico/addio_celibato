// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tasks.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TasksDto _$TasksDtoFromJson(Map<String, dynamic> json) => TasksDto(
  content: (json['content'] as List<dynamic>)
      .map((e) => TaskDto.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$TasksDtoToJson(TasksDto instance) => <String, dynamic>{
  'content': instance.content,
};
