Environment environment = const Environment(
  apiKey: '',
  port: 0,
);

class Environment {
  final String apiKey;
  final int port;

  const Environment({
    required this.apiKey,
    required this.port,
  });
}
