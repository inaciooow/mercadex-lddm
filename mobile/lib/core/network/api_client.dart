import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mercadex/core/config/app_config.dart';

class ApiClient {
  const ApiClient();

  Future<http.Response> get(String path, {String? accessToken}) {
    return http.get(_uri(path), headers: _headers(accessToken));
  }

  Future<http.Response> post(String path, Object body, {String? accessToken}) {
    return http.post(
      _uri(path),
      headers: _headers(accessToken),
      body: jsonEncode(body),
    );
  }

  Future<http.Response> delete(String path, {String? accessToken}) {
    return http.delete(_uri(path), headers: _headers(accessToken));
  }

  Uri _uri(String path) {
    if (AppConfig.apiUrl.isEmpty) {
      throw StateError('API_URL is required when mock data is disabled.');
    }

    final baseUrl = AppConfig.apiUrl.endsWith('/')
        ? AppConfig.apiUrl.substring(0, AppConfig.apiUrl.length - 1)
        : AppConfig.apiUrl;
    final normalizedPath = path.startsWith('/') ? path : '/$path';
    return Uri.parse('$baseUrl$normalizedPath');
  }

  Map<String, String> _headers(String? accessToken) {
    return {
      'Content-Type': 'application/json',
      if (accessToken != null) 'Authorization': 'Bearer $accessToken',
    };
  }
}
