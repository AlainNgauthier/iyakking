// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:iyakking/models/yakking_user.dart';
import 'package:iyakking/pages/auth.dart';
import 'package:iyakking/pages/loading_page.dart';
import 'package:iyakking/pages/yak_page.dart';
import 'package:iyakking/services/auth/auth_service.dart';
import 'package:firebase_core/firebase_core.dart';
import '../firebase_options.dart';

class AuthOrAppPage extends StatelessWidget {
  const AuthOrAppPage({Key? key}) : super(key: key);

  Future<void> init(BuildContext context) async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingPage();
          } else {
            return StreamBuilder<YakkingUser?>(
                stream: AuthService().userChanges,
                builder: (ctx, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return LoadingPage();
                  } else {
                    return snapshot.hasData ? YakPage() : Auth();
                  }
                });
          }
        },
        future: init(context));
  }
}
