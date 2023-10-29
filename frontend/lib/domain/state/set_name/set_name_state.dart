import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/domain/model/user_logged.dart';
import 'package:tensionpath/utils/navigation.dart';

class SetNameState extends BaseState {
  bool buttonEnabled = false;
  final TextEditingController nameController = TextEditingController();

  SetNameState() {
    nameController.text = LoggedUser.get.name;
  }

  void setName() {
    LoggedUser.get.updateName(nameController.text.trim());
    Navigation.mainScreen();
  }

  void onTextChanged(String text) {
    buttonEnabled = text.trim().isNotEmpty;
    notify();
  }
}
