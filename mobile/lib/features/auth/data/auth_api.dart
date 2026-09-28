import 'dart:convert';

import 'package:mercadex/core/network/api_client.dart';

class AuthApi {
  const AuthApi({this.client = const ApiClient()});

  final ApiClient client;

  Future<String> login({
    required String email,
    required String password,
  }) async {
    final response = await client.post('/auth/login', {
      'email': email,
      'password': password,
    });

    if (response.statusCode != 201) {
      throw StateError('E-mail ou senha inválidos.');
    }

    return (jsonDecode(response.body) as Map<String, dynamic>)['accessToken']
        as String;
  }
}
