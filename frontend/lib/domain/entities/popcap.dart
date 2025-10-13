class Popcap {
  static int fromElapsedTime(num elapsedTime) {
    if (elapsedTime < 30) {
      return 3;
    } else if (elapsedTime < 60) {
      return 4;
    } else if (elapsedTime < 90) {
      return 5;
    } else {
      return 6;
    }
  }
}
