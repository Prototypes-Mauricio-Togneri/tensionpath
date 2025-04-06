import 'dart:ui';

extension ColorExtension on Color {
  Color grayscale(double factor) {
    final Color color = this;
    final double luminance =
        (0.2126 * color.r + 0.7152 * color.g + 0.0722 * color.b) / 255;
    final int grayValue =
        ((1 - factor) * 255 * luminance + factor * 255).round();

    return Color.fromARGB(
      (color.a * 256).toInt(),
      grayValue,
      grayValue,
      grayValue,
    );
  }
}
