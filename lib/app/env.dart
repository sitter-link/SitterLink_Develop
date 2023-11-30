import 'package:nanny_app/core/enum/environment.dart';

class Env {
  final String baseUrl;
  final Environment type;

  Env({
    required this.baseUrl,
    required this.type,
  });

  factory Env.production() {
    return Env(
      baseUrl: "http://13.232.99.219:8002/api/v1",
      type: Environment.production,
    );
  }

  factory Env.development() {
    return Env(
      baseUrl: "http://13.232.99.219:8002/api/v1",
      type: Environment.development,
    );
  }
}
