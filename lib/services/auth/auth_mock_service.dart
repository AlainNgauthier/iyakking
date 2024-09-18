import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:iyakking/models/yakking_user.dart';
import 'package:iyakking/services/auth/auth_service.dart';

// Mock da autenticação (mock do Firebase)
class AuthMockService implements AuthService {
  // static variables / singleton pattern
  static Map<String, YakkingUser> _users = {};
  static YakkingUser? _currentUser;
  static MultiStreamController<YakkingUser?>? _controller;
  static final _userStream = Stream<YakkingUser?>.multi((controller) {
    _controller = controller;
    _updateUser(null);
  });

  YakkingUser? get currentUser {
    return _currentUser;
  }

  Stream<YakkingUser?> get userChanges {
    return _userStream;
  }

  // métodos de autenticação
  Future<void> signup(
      String name, String email, String password, File image) async {
    final newUser = YakkingUser(
        id: Random().nextDouble().toString(),
        name: name,
        email: email,
        imageURL: image.path);

    _users.putIfAbsent(email, () => newUser);
    _updateUser(newUser);
  }

  Future<void> login(String email, String password) async {
    _updateUser(_users[email]);
  }

  Future<void> logout() async {
    _updateUser(null);
  }

  static void _updateUser(YakkingUser? user) {
    _currentUser = user;
    _controller?.add(_currentUser);
  }
}
