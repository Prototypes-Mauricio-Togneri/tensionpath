import 'dart:ui';

extension PaintExtension on Paint {
  Paint grayscale(double opacity) {
    final Paint result = Paint();
    result.style = style;
    result.strokeWidth = strokeWidth;
    result.color = Color.fromARGB((255 * opacity).toInt(), 0, 0, 0);
    result.blendMode = BlendMode.luminosity;

    return result;
  }

  Paint clone({
    Color? color,
    BlendMode? blendMode,
    ColorFilter? colorFilter,
    FilterQuality? filterQuality,
    ImageFilter? imageFilter,
    bool? isAntiAlias,
    MaskFilter? maskFilter,
    Shader? shader,
    StrokeCap? strokeCap,
    StrokeJoin? strokeJoin,
    double? strokeMiterLimit,
    double? strokeWidth,
    PaintingStyle? style,
  }) {
    return Paint()
      ..color = color ?? this.color
      ..blendMode = blendMode ?? this.blendMode
      ..colorFilter = colorFilter ?? this.colorFilter
      ..filterQuality = filterQuality ?? this.filterQuality
      ..imageFilter = imageFilter ?? this.imageFilter
      ..isAntiAlias = isAntiAlias ?? this.isAntiAlias
      ..maskFilter = maskFilter ?? this.maskFilter
      ..shader = shader ?? this.shader
      ..strokeCap = strokeCap ?? this.strokeCap
      ..strokeJoin = strokeJoin ?? this.strokeJoin
      ..strokeMiterLimit = strokeMiterLimit ?? this.strokeMiterLimit
      ..strokeWidth = strokeWidth ?? this.strokeWidth
      ..style = style ?? this.style;
  }
}
