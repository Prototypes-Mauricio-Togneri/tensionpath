import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/domain/state/set_name/set_name_state.dart';
import 'package:tensionpath/widgets/base_screen.dart';
import 'package:tensionpath/widgets/custom_form_field.dart';

class SetNameScreen extends StatelessWidget {
  final SetNameState state;

  const SetNameScreen._(this.state);

  factory SetNameScreen.instance() => SetNameScreen._(SetNameState());

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      child: StateProvider<SetNameState>(
        state: state,
        builder: (context, state) => Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomFormField(
                  label: 'Nickname',
                  autofocus: true,
                  controller: state.nameController,
                  maxLength: 20,
                  onTextChanged: state.onTextChanged,
                ),
                const VBox(20),
                ElevatedButton(
                  onPressed: state.buttonEnabled ? state.setName : null,
                  child: const Text('SAVE'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
