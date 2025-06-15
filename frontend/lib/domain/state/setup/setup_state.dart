import 'package:dafluta/dafluta.dart';
import 'package:flutter/widgets.dart';
import 'package:tensionpath/environments/environment.dart';
import 'package:tensionpath/persistence/storage/name_storage.dart';
import 'package:tensionpath/utils/navigation.dart';

class SetupState extends BaseState {
  final TextEditingController nameController = TextEditingController();

  bool get canSave => nameController.text.trim().isNotEmpty;

  @override
  void onLoad() {
    if (Environment.get.isDebug) {
      nameController.text =
          'Player ${DateTime.now().millisecondsSinceEpoch % 100}';
      notify();
    }
  }

  Future onSave() async {
    final String name = nameController.text.trim();
    await NameStorage.save(name);
    Navigation.homeScreen();
  }
}
