import 'package:json_annotation/json_annotation.dart';

part 'json_version.g.dart';

@JsonSerializable()
class JsonVersion {
  @JsonKey(name: 'app_name')
  String appName;

  @JsonKey(name: 'version')
  String version;

  @JsonKey(name: 'build_number')
  String buildNumber;

  @JsonKey(name: 'package_name')
  String packageName;

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
