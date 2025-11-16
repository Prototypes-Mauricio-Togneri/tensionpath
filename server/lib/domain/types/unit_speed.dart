enum UnitSpeed {
  slow(3), // 2.5
  normal(4), // 3.5
  fast(5), // 4.5
  fastest(5.5)
  ; // 5

  final num value;

  const UnitSpeed(this.value);
}
