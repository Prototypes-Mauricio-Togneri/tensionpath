import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/domain/state/setup/setup_state.dart';
import 'package:tensionpath/presentation/common/buttons/primary_button.dart';
import 'package:tensionpath/presentation/common/container/game_container.dart';
import 'package:tensionpath/utils/palette.dart';

class SetupScreen extends StatelessWidget {
  final SetupState state;

  const SetupScreen._(this.state);

  factory SetupScreen.instance() => SetupScreen._(SetupState());

  @override
  Widget build(BuildContext context) {
    return GameContainer(child: Content(state));
  }
}

class Content extends StatelessWidget {
  final SetupState state;

  const Content(this.state);

  @override
  Widget build(BuildContext context) {
    return StateProvider<SetupState>(
      state: state,
      builder: (context, state) => Center(
        child: SizedBox(
          width: 300,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: state.nameController,
                maxLength: 15,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  labelStyle: TextStyle(color: Palette.TEXT_COLOR_PRIMARY),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Palette.PRIMARY),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Palette.PRIMARY),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Palette.PRIMARY),
                  ),
                  counterText: '',
                ),
                style: const TextStyle(color: Palette.TEXT_COLOR_PRIMARY),
                onChanged: (text) => state.notify(),
              ),
              const VBox(20),
              PrimaryButton(
                label: 'Save',
                enabled: state.canSave,
                foregroundColor: Palette.PRIMARY,
                onPressed: state.onSave,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
