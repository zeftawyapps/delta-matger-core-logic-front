import 'package:JoDija_reposatory/https/http_urls.dart';

class projectConfig {
  String baseUrl = '';
  String imageUrl = '';

  projectConfig({String? myBaseUrl, String? myImageUrl}) {
    this.baseUrl = myBaseUrl ?? 'http://localhost:3000/api/v1';
    this.imageUrl = myImageUrl ?? 'http://localhost:3000';
    initConfigration();
  }

  void initConfigration() {
    HttpUrlsEnveiroment(baseUrl: baseUrl, imageBaseUrl: imageUrl);
  }
}

class ProjectAPIHeader {
  static void setHeader(String? token) {
    HttpHeader().setAuthHeader(token ?? "", Bearer: "Bearer ");
  }
}
