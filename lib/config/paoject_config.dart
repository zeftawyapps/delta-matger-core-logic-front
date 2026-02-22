import 'package:JoDija_reposatory/https/http_urls.dart';

class projectConfig {
  final String baseUrl = 'http://localhost:3000/api/v1';

  initConfigration() {
    HttpUrlsEnveiroment(baseUrl: baseUrl);
  }
}
