extension NumExtension on num {
  num rounded() => toInt() == this ? this : num.parse(toStringAsFixed(2));
}
