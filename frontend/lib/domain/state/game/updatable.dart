mixin Updatable {
  bool _update = false;

  void setUpdate() {
    _update = true;
  }

  bool get shouldUpdate {
    if (_update) {
      _update = false;

      return true;
    } else {
      return false;
    }
  }
}
