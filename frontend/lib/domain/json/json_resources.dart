import 'package:json_annotation/json_annotation.dart';

part 'json_resources.g.dart';

@JsonSerializable()
class JsonResources {
  @JsonKey(name: 'amount')
  final double amount;

  const JsonResources({required this.amount});

  factory JsonResources.fromJson(Map<String, dynamic> json) =>
      _$JsonResourcesFromJson(json);

  Map<String, dynamic> toJson() => _$JsonResourcesToJson(this);
}
