import 'package:flutter/material.dart';
import 'package:iyakking/components/auth_form.dart';
import 'package:iyakking/models/auth_form_data.dart';
import 'package:iyakking/services/auth/auth_service.dart';

class Auth extends StatefulWidget {
  const Auth({super.key});

  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  bool isLoading = false;

  Future<void> handleSubmit(AuthFormData formData) async {
    try {
      // if (!mounted) return;
      setState(() => isLoading = true);

      if (formData.isLogin) {
        AuthService().login(formData.email, formData.password);
      } else {
        AuthService().signup(
            formData.name, formData.email, formData.password, formData.image);
      }
    } catch (err) {
      // TODO: Handling error
    } finally {
      // if (!mounted) return;
      setState(() => isLoading = false);
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
