import 'package:flutter/material.dart';
import 'package:iyakking/components/auth_form.dart';
import 'package:iyakking/models/auth_form_data.dart';

class Auth extends StatefulWidget {
  const Auth({super.key});

  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  bool isLoading = false;

  Future<void> handleSubmit(AuthFormData formData) async {
    try {
      setState(() => isLoading = true); //

      if (formData.isLogin) {
      } else {
        // signup
      }
    } catch (err) {
      // erro
    } finally {
      setState(() => isLoading = false); //
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              child: AuthForm(onSubmit: handleSubmit),
            ),
          ),
          if (isLoading)
            Container(
              decoration:
                  const BoxDecoration(color: Color.fromRGBO(0, 0, 0, 0.3)),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            )
        ],
      ),
    );
  }
}
