import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_auth_provider/auth/login_screen.dart';
import 'package:supabase_auth_provider/providers/auth_provider.dart';
import 'package:supabase_auth_provider/screens/home_screen_stream.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});
  @override
  Widget build(BuildContext context) {
    final session = context.watch<AuthProvider>().session;

    if (session != null) {
      return const HomeScreenStream();
    } else {
      return const LoginScreen();
    }
  }
}
