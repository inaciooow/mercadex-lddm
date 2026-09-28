import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mercadex/features/auth/domain/auth_session.dart';

final authSessionProvider = NotifierProvider<AuthSessionNotifier, AuthSession?>(
  AuthSessionNotifier.new,
);

class AuthSessionNotifier extends Notifier<AuthSession?> {
  @override
  AuthSession? build() => null;

  void logIn({required String email, required String accessToken}) {
    state = AuthSession(email: email, accessToken: accessToken);
  }

  void logOut() {
    state = null;
  }
}
