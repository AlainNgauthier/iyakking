// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:iyakking/models/yakking_user.dart';
import 'package:iyakking/services/auth/auth_service.dart';

class AuthFirebaseService implements AuthService {
  // static variables / singleton pattern
  static YakkingUser? _currentUser;

  // retorno do user do authStateChange armazenado no Stream
  static final _userStream = Stream<YakkingUser?>.multi((controller) async {
    final authChanges = FirebaseAuth.instance.authStateChanges();
    await for (final user in authChanges) {
      _currentUser = user == null ? null : toYakkingUser(user);
      controller.add(_currentUser);
    }
  });

  YakkingUser? get currentUser {
    return _currentUser;
  }

  Stream<YakkingUser?> get userChanges {
    return _userStream;
  }

  // AUTHENTICATION METHODS: SIGNUP, LOGOUT, LOGIN
  Future<void> signup(
      String name, String email, String password, File? image) async {
    final auth = FirebaseAuth.instance;

    // creating user
    UserCredential credential = await auth.createUserWithEmailAndPassword(
        email: email, password: password);

    if (credential.user == null) return;

    // updating user credentials
    await credential.user?.updateDisplayName(name);

    // saving to the firestore
    await saveYakkingUser(toYakkingUser(credential.user!));
  }

  Future<void> login(String email, String password) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> logout() async {
    FirebaseAuth.instance.signOut();
  }

  // Adding a user to the "DB" firestore: collection table + doc register
  Future<void> saveYakkingUser(YakkingUser user) async {
    final store = FirebaseFirestore.instance;
    final docRef = store.collection('users').doc(user.id);

    return docRef.set({
      'name': user.name,
      'email': user.email,
      'imageURL': user.imageURL,
    });
  }

  static YakkingUser toYakkingUser(User user) {
    return YakkingUser(
        id: user.uid,
        name: user.displayName ?? user.email!.split('@')[0],
        email: user.email!,
        imageURL: user.photoURL ?? 'assets/images/avatar.png');
  }
}
