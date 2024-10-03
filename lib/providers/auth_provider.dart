import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_pantry/services/database_services.dart';

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


  Future<void> signUpWithEmail(String displayName, String email, String password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ).then((userCredential) => DatabaseService().addUser(displayName, userCredential));
//TODO add name to credentials
    } catch (error) {
      rethrow;
    }
  }


  Future<void> signInAnonymous() async {
    await _firebaseAuth.signInAnonymously();
  }


  Future<UserCredential> signInWithEmail(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
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