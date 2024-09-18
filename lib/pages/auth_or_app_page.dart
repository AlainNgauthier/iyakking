// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:iyakking/pages/auth.dart';
import 'package:iyakking/pages/loading_page.dart';
import 'package:iyakking/pages/yak_page.dart';
import 'package:iyakking/services/auth/auth_mock_service.dart';

class AuthOrAppPage extends StatelessWidget {
  const AuthOrAppPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: AuthMockService().userChanges,
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return LoadingPage();
            } else {
              return snapshot.hasData ? YakPage() : Auth();
            }
          }),
    );
  }
}
