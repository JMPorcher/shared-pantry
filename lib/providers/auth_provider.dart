import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SpAuthProvider extends ChangeNotifier {
  SpAuthProvider() {
    _authStateStream = _firebaseAuth.authStateChanges();
  }

  late Stream<User?> _authStateStream;
  Stream<User?> get authStateStream => _authStateStream;

  Future<User?> getCurrentUser() async {
    return _firebaseAuth.currentUser;
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseAuth get firebaseAuth => _firebaseAuth;

  User? _user;
  User? get user => _user;


  Future<void> signUpWithEmail(String email, String password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (error) {
      rethrow;
    }
  }


  Future<void> signInAnonymous() async {
    await _firebaseAuth.signInAnonymously();
  }


  Future<void> signInWithEmail(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (error) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (error) {
      rethrow;
    }
  }
}