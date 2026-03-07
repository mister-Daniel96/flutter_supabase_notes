import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_auth_provider/auth/auth_gate.dart';
import 'package:supabase_auth_provider/providers/auth_provider.dart';
import 'package:supabase_auth_provider/providers/note_provider.dart';
import 'package:supabase_auth_provider/providers/note_provider_stream.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  final supabaseUrl = 'https://kdjnhtcgaiqnjlyvlqjb.supabase.co';
  final supabaseKey = 'sb_publishable_pTVL8x3ToteT8KbkM-1xpg_XiGbXeTe';
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseKey);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
         ChangeNotifierProvider<NoteProvider>(create: (_) => NoteProvider()),

         ChangeNotifierProvider<NoteProviderStream>(create: (_) => NoteProviderStream()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
        home: AuthGate(),
      ),
    );
  }
}
