enum Environment { dev, prod }

class EnvConfig {
  static const String _env = String.fromEnvironment('ENV', defaultValue: 'dev');

  static Environment get environment {
    switch (_env) {
      case 'prod':
        return Environment.prod;
      default:
        return Environment.dev;
    }
  }

  static bool get isProd => environment == Environment.prod;
}
