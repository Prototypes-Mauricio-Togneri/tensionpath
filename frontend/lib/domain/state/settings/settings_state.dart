import 'package:dafluta/dafluta.dart';
import 'package:flutter/widgets.dart';
import 'package:tensionpath/persistence/storage/settings_storage.dart';
import 'package:tensionpath/utils/audio.dart';
import 'package:tensionpath/utils/navigation.dart';
import 'package:tensionpath/utils/version.dart';

class SettingsState extends BaseState {
  final TextEditingController nameController = TextEditingController();
  String version = '';

  bool get canSave => nameController.text.trim().isNotEmpty;

  @override
  Future onLoad() async {
    nameController.text = await SettingsStorage.loadName();
    notify();

    version = 'v${Version.version} (${Version.build})';
    notify();
  }

  void onClose() => Navigation.pop();

  void onAudioToggle() {
    Audio.get.toggle();
    notify();
  }

  Future onSave() async {
    final String name = nameController.text.trim();
    await SettingsStorage.saveName(name);
    Navigation.pop();
  }
}
