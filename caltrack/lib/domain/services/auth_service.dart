import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:developer';

class AuthService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<void> signUp(String email, String password) async {
    final response =
        await _supabase.auth.signUp(email: email, password: password);

    if (response.user == null) {
      throw Exception('Sign-up failed.');
    }

    log("User signed up: ${response.user!.email}");
  }

  Future<void> signIn(String email, String password) async {
    final response = await _supabase.auth
        .signInWithPassword(email: email, password: password);

    if (response.session == null) {
      throw Exception('Sign-in failed.');
    }

    log("User signed in: ${response.user!.email}");
  }

  Future<void> signOut() async {
    await _supabase.auth.signOut();
    log("User signed out");
  }

  bool isLoggedIn() {
    return _supabase.auth.currentUser != null;
  }

  User? getCurrentUser() {
    return _supabase.auth.currentUser;
  }
}
