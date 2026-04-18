import 'package:fe/models/task.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tasks.g.dart';

@JsonSerializable()
class TasksDto {
  final List<TaskDto> content;

  TasksDto({
    required this.content,
  });

  factory TasksDto.fromJson(Map<String, dynamic> json) =>
      _$TasksDtoFromJson(json);

  Map<String, dynamic> toJson() => _$TasksDtoToJson(this);
}