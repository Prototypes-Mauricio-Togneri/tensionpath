import 'package:dafluta/dafluta.dart';
import 'package:flutter/services.dart';
import 'package:tensionpath/utils/navigation.dart';

class ChangelogState extends BaseState {
  String text = '';

  bool get isLoading => text.isEmpty;

  @override
  Future onLoad() async {
    text = await rootBundle.loadString('assets/text/changelog.txt');
    notify();
  }

  void onClose() => Navigation.pop();
}
