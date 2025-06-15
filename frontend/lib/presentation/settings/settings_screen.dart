import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/domain/state/settings/settings_state.dart';
import 'package:tensionpath/presentation/common/buttons/top_button.dart';
import 'package:tensionpath/presentation/common/container/game_container.dart';
import 'package:tensionpath/presentation/common/text/label.dart';
import 'package:tensionpath/utils/audio.dart';
import 'package:tensionpath/utils/authentication.dart';
import 'package:tensionpath/utils/palette.dart';

class SettingsScreen extends StatelessWidget {
  final SettingsState state;

  const SettingsScreen._(this.state);

  factory SettingsScreen.instance() => SettingsScreen._(SettingsState());

  @override
  Widget build(BuildContext context) {
    return GameContainer(child: Content(state));
  }
}

class Content extends StatelessWidget {
  final SettingsState state;

  const Content(this.state);

  @override
  Widget build(BuildContext context) {
    return StateProvider<SettingsState>(
      state: state,
      builder: (context, state) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TopButtons(state),
          const Spacer(),
          AudioSection(state),
          const VBox(20),
          Form(state),
          const Spacer(),
          Footer(state),
        ],
      ),
    );
  }
}

class TopButtons extends StatelessWidget {
  final SettingsState state;

  const TopButtons(this.state);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [TopButton(icon: Icons.arrow_back, onPressed: state.onClose)],
    );
  }
}

class AudioSection extends StatelessWidget {
  final SettingsState state;

  const AudioSection(this.state);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Label(text: 'Audio', color: Palette.TEXT_COLOR_PRIMARY, size: 14),
        const HBox(30),
        Switch(
          value: Audio.get.enabled,
          onChanged: (v) => state.onAudioToggle(),
        ),
      ],
    );
  }
}

class Form extends StatelessWidget {
  final SettingsState state;

  const Form(this.state);

  @override
  Widget build(BuildContext context) {
    return StateProvider<SettingsState>(
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
              const VBox(30),
              ElevatedButton(
                onPressed: state.canSave ? state.onSave : null,
                style: ButtonStyle(
                  foregroundColor: WidgetStateProperty.resolveWith<Color>(
                    (states) => Palette.TEXT_COLOR_SECONDARY,
                  ),
                  backgroundColor: WidgetStateProperty.resolveWith<Color>((
                    states,
                  ) {
                    if (states.contains(WidgetState.disabled)) {
                      return Palette.BUTTON_DISABLED;
                    } else {
                      return Palette.PRIMARY;
                    }
                  }),
                ),
                child: const Text('SAVE'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Footer extends StatelessWidget {
  final SettingsState state;

  const Footer(this.state);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          state.version,
          style: TextStyle(color: Palette.TEXT_COLOR_PRIMARY.withAlpha(128)),
        ),
        const VBox(15),
        SelectableText(
          Authentication.userId,
          style: TextStyle(color: Palette.TEXT_COLOR_PRIMARY.withAlpha(128)),
        ),
        const VBox(10),
      ],
    );
  }
}
