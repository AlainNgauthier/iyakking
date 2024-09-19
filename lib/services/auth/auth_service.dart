import 'dart:io';

import 'package:iyakking/models/yakking_user.dart';
import 'package:iyakking/services/auth/auth_firebase_service.dart';

abstract class AuthService {
  YakkingUser? get currentUser;
  Stream<YakkingUser?> get userChanges;

  // métodos de autenticação
  Future<void> signup(String nome, String email, String password, File? image);
  Future<void> login(String email, String password);
  Future<void> logout();

  factory AuthService() {
    // return AuthMockService();
    return AuthFirebaseService();
  }
}
