import 'dart:developer';

import 'package:conference_organizer_app/providers/auth_provider.dart';
import 'package:conference_organizer_app/widgets/my_text_form.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "../globals.dart" as globals;

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _emailController = TextEditingController();
    var _passController = TextEditingController();
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        'Conference Organizer',
      )),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.fromLTRB(550, 150, 550, 10),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Login",
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Email",
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  const SizedBox(height: 7),
                  MyTextForm(
                    textFildController: _emailController,
                    hint: "email",
                    errorMsg: "The field email must not be empty!",
                    fildForPass: false,
                  ),
                  const SizedBox(height: 30),
                  Text(
                    "Password",
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  const SizedBox(height: 7),
                  MyTextForm(
                    textFildController: _passController,
                    errorMsg: "The field password must not be empty !",
                    hint: "password",
                    fildForPass: true,
                  ),
                  const SizedBox(height: 20),
                  Consumer<AuthProvider>(
                      builder: (context, loginProvider, child) =>
                          ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.blue),
                                  minimumSize: MaterialStateProperty.all(
                                      const Size(double.infinity, 50)),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(28.0),
                                  ))),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  loginProvider
                                      .login(_emailController.text,
                                          _passController.text)
                                      .then((value) {
                                    if (value) {
                                      Navigator.pushNamed(context,
                                          globals.navigatorDrawerRoute);
                                    } else {
                                      showDialog(
                                        context: context,
                                        builder: (_) => AlertDialog(
                                          title: const Text('Warning!'),
                                          content: const Text(
                                              'An error has occurred, check the credentials and try again.'),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text('OK'),
                                            ),
                                          ],
                                        ),
                                      );
                                    }
                                  });
                                }
                              },
                              child: const Text("Login",
                                  style: TextStyle(
                                    fontSize: 20.0,
                                  )))),
                  const SizedBox(
                    height: 20,
                  ),
                  RichText(
                    text: TextSpan(children: [
                      TextSpan(
                          text: "Sign up",
                          style: const TextStyle(
                              fontSize: 15, color: Colors.white),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushNamed(
                                  context, globals.registrationScreenRoute);
                            }),
                    ]),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
