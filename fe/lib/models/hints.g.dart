// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hints.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HintsDto _$HintsDtoFromJson(Map<String, dynamic> json) => HintsDto(
  content: (json['content'] as List<dynamic>)
      .map((e) => HintDto.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$HintsDtoToJson(HintsDto instance) => <String, dynamic>{
  'content': instance.content,
};
