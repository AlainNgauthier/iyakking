// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RefreshProgressIndicator(),
            SizedBox(height: 30),
            Text(
              'Loading',
              style: TextStyle(
                color: Theme.of(context).primaryTextTheme.headlineMedium?.color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
