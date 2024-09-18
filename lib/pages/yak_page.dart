import 'package:flutter/material.dart';
import 'package:iyakking/services/auth/auth_mock_service.dart';

class YakPage extends StatelessWidget {
  const YakPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text('Yak page'),
          TextButton(
              onPressed: () {
                AuthMockService().logout();
              },
              child: Text('Logout')),
        ]),
      ),
    );
  }
}
