import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:tensionpath/domain/json/json_match.dart';
import 'package:tensionpath/persistence/repository/match_repository.dart';
import 'package:tensionpath/utils/assets.dart';

class CreateMatchCallable {
  Future<String> call({required Map<String, String> players}) async {
    final String content = await rootBundle.loadString(Assets.TEMPLATES_W9H7);
    final JsonMatch json = JsonMatch.fromJson(jsonDecode(content));

    return MatchRepository.create(json);
  }
}
