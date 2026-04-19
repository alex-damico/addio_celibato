import 'package:json_annotation/json_annotation.dart';

part 'task_create.g.dart';

@JsonSerializable()
class TaskCreateDto {
  final String content;

  TaskCreateDto({required this.content});

  factory TaskCreateDto.fromJson(Map<String, dynamic> json) =>
      _$TaskCreateDtoFromJson(json);

  Map<String, dynamic> toJson() => _$TaskCreateDtoToJson(this);
}
