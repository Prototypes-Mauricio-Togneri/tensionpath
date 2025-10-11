class AlertTimer {
  double counter = 0;
  final double interval;

  AlertTimer(this.interval);

  void update(double dt) {
    counter += dt;
  }

  bool get isReady {
    if (counter >= interval) {
      counter = 0;
      return true;
    } else {
      return false;
    }
  }
}
