import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthProvider with ChangeNotifier {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<void> signIn(String email, String password) async {
    try {
      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      if (response.session != null) {
        notifyListeners();
      } else {
        throw Exception('Login failed');
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<void> signUp(String email, String password) async {
    try {
      final response = await _supabase.auth.signUp(
        email: email,
        password: password,
      );
      if (response.session != null) {
        notifyListeners();
      } else {
        throw Exception('Signup failed');
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    await _supabase.auth.signOut();
    notifyListeners();
  }

  Stream<User?> authStateChanges() {
    return _supabase.auth.onAuthStateChange.map((event) => event.session?.user);
  }
}
