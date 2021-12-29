import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  final DotEnv _dotEnv = dotenv;

  final String secretsPath;
  final String environmentPath;

  Environment({
    required this.environmentPath,
    required this.secretsPath,
  });

  Future<void> initialize() async {
    await _dotEnv.load(fileName: secretsPath);
    final secrets = Map.fromEntries(_dotEnv.env.entries);
    await _dotEnv.load(fileName: environmentPath, mergeWith: secrets);
  }

  String getOrElse(String key, String orElse) {
    return _dotEnv.get(key, fallback: orElse);
  }
}
