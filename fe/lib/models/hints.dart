import 'package:addio_celibato/models/hint.dart';
import 'package:json_annotation/json_annotation.dart';

part 'hints.g.dart';

@JsonSerializable()
class HintsDto {
  final List<HintDto> content;

  HintsDto({required this.content});

  factory HintsDto.fromJson(Map<String, dynamic> json) =>
      _$HintsDtoFromJson(json);

  Map<String, dynamic> toJson() => _$HintsDtoToJson(this);
}