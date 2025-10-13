class Popcap {
  static int fromElapsedTime(num timeElapsed) {
    if (timeElapsed < 30) {
      return 3;
    } else if (timeElapsed < 60) {
      return 4;
    } else if (timeElapsed < 90) {
      return 5;
    } else {
      return 6;
    }
  }
}
