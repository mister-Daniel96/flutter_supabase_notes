import 'package:flutter/foundation.dart';
import 'package:supabase_auth_provider/auth/auth_service/auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();

  Session? _session;
  bool _isLoading = false;

  AuthProvider() {
    /* Valida si habia una sesion guardada */
    _session = _authService.currentSession;
    /* Escucha a Supabase.
      Cada vez que cambie la sesión, actualiza el estado
      y avisa a la UI.
      */
    _authService.authState.listen((data) {
      _session = data.session;
      notifyListeners();
    });
  }

  Future<void> signIn(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    await _authService.signIn(email, password);

    _isLoading = false;
    notifyListeners();
  }

  Future<void> signUp(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    await _authService.signUp(email, password);

    _isLoading = false;
    notifyListeners();
  }

  Future<void> signOut() async {
    await _authService.signOut();
  }

  Session? get session => _session;
  bool get isLoading => _isLoading;
}
