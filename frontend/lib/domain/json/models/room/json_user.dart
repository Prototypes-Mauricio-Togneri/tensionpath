import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/entities/room.dart';
import 'package:tensionpath/domain/types/unit_type.dart';

part 'json_user.g.dart';

@JsonSerializable()
class JsonUser {
  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'deck')
  final List<UnitType> deck;

  const JsonUser({
    required this.name,
    required this.deck,
  });

  User get object => User(
    name: name,
    deck: deck,
  );

  factory JsonUser.fromJson(Map<String, dynamic> json) =>
      _$JsonUserFromJson(json);

  Map<String, dynamic> toJson() => _$JsonUserToJson(this);
}
