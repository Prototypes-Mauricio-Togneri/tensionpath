class Environment {
  final String apiKey;
  final int port;
  final bool createTestMatch;
  final bool showLogs;

  const Environment({
    required this.apiKey,
    required this.port,
    required this.createTestMatch,
    required this.showLogs,
  });

  String get maskedApiKey {
    final String first3 = apiKey.substring(0, 3);
    final String last3 = apiKey.substring(apiKey.length - 3);
    final int middleLength = apiKey.length - 6;

    return '$first3${'*' * middleLength}$last3';
  }
}
