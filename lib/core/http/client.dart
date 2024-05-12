import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:rankai/core/http/app_interceptor.dart';

class HTTP {
  final Dio client = createClient();

  static Dio createClient() {
    const baseUrl = 'https://api.openai.com/v1';
    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        validateStatus: (status) => true,
        contentType: Headers.jsonContentType,
        headers: {
          "Authorization": "Bearer ${dotenv.env['API_KEY']}",
          "OpenAI-Organization": dotenv.env['API_ORGANIZATION'],
        },
      ),
    );

    dio.interceptors.add(AppInterceptors(dio));

    return dio;
  }
}
