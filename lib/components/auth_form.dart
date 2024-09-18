import 'dart:io';

import 'package:flutter/material.dart';
import 'package:iyakking/components/user_image_picker.dart';
import 'package:iyakking/models/auth_form_data.dart';
import 'package:validatorless/validatorless.dart';

class AuthForm extends StatefulWidget {
  final void Function(AuthFormData) onSubmit;

  const AuthForm({
    super.key,
    required this.onSubmit,
  });

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  final _formData = AuthFormData();

  void handleSubmit() {
    final isValidForm = _formKey.currentState?.validate() ?? false;
    if (!isValidForm) return;

    if (_formData.image == null && _formData.isSignup) {
      return showErrorMessage('Please, add an image to sign up');
    }

    widget.onSubmit(_formData);
  }

  void showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Container(
        margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                message,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              )
            ],
          ),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 223, 138, 68),
      behavior: SnackBarBehavior.floating,
    ));
  }

  void handleImagePicker(File image) {
    _formData.image = image;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.all(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                if (_formData.isSignup)
                  UserImagePicker(onImagePick: handleImagePicker),
                if (_formData.isSignup)
                  TextFormField(
                    key: const ValueKey('name'),
                    decoration: const InputDecoration(labelText: 'Name'),
                    initialValue: _formData.name,
                    onChanged: (name) => _formData.name = name,
                    validator: Validatorless.multiple([
                      Validatorless.required('Name is required'),
                      Validatorless.min(
                          3, 'Name must be at least 3 characters'),
                      Validatorless.max(
                          20, 'Name must be at most 20 characters'),
                    ]),
                  ),
                TextFormField(
                  key: const ValueKey('email'),
                  decoration: const InputDecoration(labelText: 'Email'),
                  initialValue: _formData.email,
                  onChanged: (email) => _formData.email = email,
                  validator: (xemail) {
                    final email = xemail ?? '';
                    if (!email.contains('@')) {
                      return 'Invalid email';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  obscureText: true,
                  key: const ValueKey('password'),
                  decoration: const InputDecoration(labelText: 'Password'),
                  initialValue: _formData.password,
                  onChanged: (password) => _formData.password = password,
                  validator: Validatorless.multiple([
                    Validatorless.required('Password is required'),
                    Validatorless.min(
                        8, 'Password must be at least 6 characters'),
                    Validatorless.max(
                        20, 'Password must be at most 20 characters'),
                  ]),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                    onPressed: handleSubmit,
                    child: Text(_formData.isSignup ? 'Sign Up' : 'Login')),
                TextButton(
                    onPressed: () {
                      setState(() {
                        _formData.toggleAuthMode();
                      });
                    },
                    child: Text(_formData.isSignup
                        ? 'Already have an account ?'
                        : 'Do not have a count yet ?'))
              ],
            ),
          ),
        ));
  }
}
