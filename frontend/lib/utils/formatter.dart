import 'package:intl/intl.dart';

class Formatter {
  static String production(num amount) {
    final NumberFormat formatter = NumberFormat('#.##');

    return formatter.format(amount);
  }

  static String rate(num amount) {
    final NumberFormat formatter = NumberFormat('#.##');
    final String value = formatter.format(amount * 100);

    return '$value%';
  }

  static String hoursMinutes(int seconds) {
    final int minutes = seconds ~/ 60;
    final int remainingSeconds = seconds % 60;
    
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }
}
