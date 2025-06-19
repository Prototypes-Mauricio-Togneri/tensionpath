import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/presentation/common/buttons/primary_button.dart';
import 'package:tensionpath/utils/navigation.dart';
import 'package:tensionpath/utils/palette.dart';
import 'package:tensionpath/utils/platform.dart';

class MatchMenuDialog extends StatelessWidget {
  final VoidCallback onFullscreen;
  final VoidCallback onSurrender;

  const MatchMenuDialog._(this.onFullscreen, this.onSurrender);

  static DialogController show({
    required VoidCallback onFullscreen,
    required VoidCallback onSurrender,
  }) {
    final BuildContext context = Navigation.context();

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => MatchMenuDialog._(onFullscreen, onSurrender),
    );

    return DialogController(context);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: AlertDialog(
        contentPadding: const EdgeInsets.only(
          top: 20,
          left: 20,
          right: 20,
          bottom: 20,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (Platform.isMobile)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: PrimaryButton(
                  label: 'Fullscreen',
                  enabled: true,
                  fullWidth: true,
                  foregroundColor: Palette.PRIMARY,
                  onPressed: () {
                    Navigation.pop();
                    onFullscreen.call();
                  },
                ),
              ),
            PrimaryButton(
              label: 'Surrender',
              enabled: true,
              fullWidth: true,
              foregroundColor: Palette.SEMANTIC_ERROR,
              onPressed: () {
                Navigation.pop();
                onSurrender.call();
              },
            ),
            const VBox(40),
            const PrimaryButton(
              label: 'Close',
              enabled: true,
              fullWidth: true,
              foregroundColor: Palette.BUTTON_DISABLED,
              onPressed: Navigation.pop,
            ),
          ],
        ),
      ),
    );
  }
}
