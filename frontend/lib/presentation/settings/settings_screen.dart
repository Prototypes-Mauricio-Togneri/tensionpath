import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/domain/models/user_logged.dart';
import 'package:tensionpath/domain/state/settings/settings_state.dart';
import 'package:tensionpath/utils/navigation.dart';
import 'package:tensionpath/utils/palette.dart';
import 'package:tensionpath/widgets/base_screen.dart';
import 'package:tensionpath/widgets/custom_form_field.dart';
import 'package:tensionpath/widgets/label.dart';
import 'package:tensionpath/widgets/primary_button.dart';

class SettingsScreen extends StatelessWidget {
  final SettingsState state;

  const SettingsScreen._(this.state);

  factory SettingsScreen.instance(bool isSetup) =>
      SettingsScreen._(SettingsState(isSetup));

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !state.isSetup,
      child: BaseScreen(
        child: StateProvider<SettingsState>(
          state: state,
          builder: (context, state) => Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (!state.isSetup)
                const Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    onPressed: Navigation.pop,
                    icon: Icon(
                      Icons.arrow_back,
                      color: Palette.grey,
                      size: 25,
                    ),
                  ),
                ),
              SizedBox(
                width: 300,
                child: CustomFormField(
                  label: 'Nickname',
                  autofocus: true,
                  controller: state.nameController,
                  maxLength: 20,
                  onTextChanged: state.onTextChanged,
                ),
              ),
              const VBox(20),
              PrimaryButton(
                text: 'SAVE',
                onPressed: state.buttonEnabled ? state.onSave : null,
              ),
              const Spacer(),
              Label(
                text: LoggedUser.get.id,
                color: Palette.grey,
                size: 14,
              ),
              const VBox(20),
            ],
          ),
        ),
      ),
    );
  }
}
