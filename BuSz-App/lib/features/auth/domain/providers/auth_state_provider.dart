import 'package:flutter_riverpod/flutter_riverpod.dart';

enum AuthState { initial, unauthenticated, authenticated }

class AuthNotifier extends Notifier<AuthState> {
  @override
  AuthState build() {
    // Simulate initial check
    _checkInitialAuth();
    return AuthState.initial;
  }

  Future<void> _checkInitialAuth() async {
    // TODO: Connect to secure storage or mock repo to check token
    await Future.delayed(const Duration(seconds: 1));
    state = AuthState.unauthenticated;
  }

  void login() {
    state = AuthState.authenticated;
  }

  void logout() {
    state = AuthState.unauthenticated;
  }
}

final authStateProvider = NotifierProvider<AuthNotifier, AuthState>(() {
  return AuthNotifier();
});
