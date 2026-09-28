import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mercadex/features/auth/data/auth_repository.dart';
import 'package:mercadex/features/auth/presentation/auth_session_provider.dart';
import 'package:mercadex/widgets/app_top_bar.dart';
import 'package:mercadex/widgets/app_notification.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  var _isSubmitting = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    if (email.isEmpty || password.isEmpty) {
      showAppNotification(context, 'Informe seu e-mail e senha.');
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      final accessToken = await const AuthRepository().login(
        email: email,
        password: password,
      );
      if (!mounted) {
        return;
      }

      ref
          .read(authSessionProvider.notifier)
          .logIn(email: email, accessToken: accessToken);

      showAppNotification(context, 'Login realizado com sucesso.');
      context.pop();
    } catch (_) {
      if (!mounted) {
        return;
      }

      showAppNotification(context, 'E-mail ou senha inválidos.');
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppTopBar(title: 'Entrar'),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Boas-vindas de volta',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          const Text(
            'Entre para compartilhar e confirmar ofertas de alimentos.',
          ),
          const SizedBox(height: 24),
          TextField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(labelText: 'E-mail'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _passwordController,
            obscureText: true,
            decoration: const InputDecoration(labelText: 'Senha'),
          ),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: _isSubmitting ? null : _login,
            child: Text(_isSubmitting ? 'Entrando...' : 'Entrar'),
          ),
        ],
      ),
    );
  }
}
