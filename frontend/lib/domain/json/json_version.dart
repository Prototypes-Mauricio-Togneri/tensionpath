import 'package:json_annotation/json_annotation.dart';

part 'json_version.g.dart';

@JsonSerializable()
class JsonVersion {
  @JsonKey(name: 'app_name')
  final String appName;

  @JsonKey(name: 'version')
  final String version;

  @JsonKey(name: 'build_number')
  final String buildNumber;

  @JsonKey(name: 'package_name')
  final String packageName;

  JsonVersion({
    required this.appName,
    required this.version,
    required this.buildNumber,
    required this.packageName,
  });

  factory JsonVersion.fromJson(Map<String, dynamic> json) =>
      _$JsonVersionFromJson(json);

  Map<String, dynamic> toJson() => _$JsonVersionToJson(this);
}
