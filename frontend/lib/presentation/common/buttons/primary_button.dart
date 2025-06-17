import 'package:flutter/material.dart';
import 'package:tensionpath/utils/palette.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final Color foregroundColor;
  final bool enabled;
  final VoidCallback onPressed;

  const PrimaryButton({
    required this.label,
    required this.enabled,
    required this.foregroundColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: enabled ? onPressed : null,
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.resolveWith<Color>(
          (states) => Palette.TEXT_COLOR_TERTIARY,
        ),
        backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.disabled)) {
            return Palette.BUTTON_DISABLED;
          } else {
            return foregroundColor;
          }
        }),
      ),
      child: Text(label.toUpperCase()),
    );
  }
}
