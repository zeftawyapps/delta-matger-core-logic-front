import 'package:JoDija_reposatory/https/http_urls.dart';

class projectConfig {
  String baseUrl = '';
  projectConfig({String? myBaseUrl}) {
    this.baseUrl = myBaseUrl ?? 'http://localhost:3000/api/v1';
    initConfigration();
  }

  void initConfigration() {
    HttpUrlsEnveiroment(baseUrl: baseUrl);
  }
}
