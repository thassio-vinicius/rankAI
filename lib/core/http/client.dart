import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class HTTP {
  final Dio client = createClient();

  static Dio createClient() {
    const baseUrl = 'https://api.openai.com/v1/chat';
    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        contentType: Headers.jsonContentType,
        headers: {"Authorization": "Bearer ${dotenv.env['API_KEY']}"},
      ),
    );

    return dio;
  }

  void setAuthorizationHeader(String idToken) {
    client.options.headers["Authorization"] = "Bearer $idToken";
  }

  void removeAuthorizationHeader() {
    client.options.headers.remove("Authorization");
  }
}
