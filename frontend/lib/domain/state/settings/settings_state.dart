import 'package:dafluta/dafluta.dart';
import 'package:flutter/widgets.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:tensionpath/persistence/storage/settings_storage.dart';
import 'package:tensionpath/utils/audio.dart';
import 'package:tensionpath/utils/navigation.dart';

class SettingsState extends BaseState {
  final TextEditingController nameController = TextEditingController();
  String version = '';

  bool get canSave => nameController.text.trim().isNotEmpty;

  @override
  Future onLoad() async {
    nameController.text = await SettingsStorage.loadName();
    notify();

    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version = 'v${packageInfo.version} (${packageInfo.buildNumber})';
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
