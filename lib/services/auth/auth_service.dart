import 'dart:io';

import 'package:iyakking/models/yakking_user.dart';

abstract class AuthService {
  YakkingUser? get currentUser;
  Stream<YakkingUser?> get userChanges;

  // métodos de autenticação
  Future<void> signup(String nome, String email, String password, File image);
  Future<void> login(String email, String password);
  Future<void> logout();
}
