import 'package:conference_organizer_app/providers/auth_provider.dart';
import 'package:conference_organizer_app/widgets/my_text_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _firstNameController = TextEditingController();
    var _lastNameController = TextEditingController();
    var _emailController = TextEditingController();
    var _passController = TextEditingController();
    final _formKey = GlobalKey<FormState>();
    return ChangeNotifierProvider.value(
        value: AuthProvider(),
        builder: (context, child) => Scaffold(
              appBar: AppBar(
                title: Text('Conference Organizer'),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(550, 100, 550, 10),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Registration",
                            style: Theme.of(context).textTheme.headline1),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "First name",
                          style: Theme.of(context).textTheme.headline2,
                        ),
                        const SizedBox(height: 7),
                        MyTextForm(
                            textFildController: _firstNameController,
                            errorMsg: "Polje first name ne smije biti prazno!",
                            hint: "first name"),
                        const SizedBox(height: 30),
                        Text(
                          "Last name",
                          style: Theme.of(context).textTheme.headline2,
                        ),
                        const SizedBox(height: 7),
                        MyTextForm(
                            textFildController: _lastNameController,
                            errorMsg: "Polje last name ne smije biti prazno!",
                            hint: "last name"),
                        const SizedBox(height: 30),
                        Text(
                          "E-mail",
                          style: Theme.of(context).textTheme.headline2,
                        ),
                        const SizedBox(height: 7),
                        MyTextForm(
                            textFildController: _emailController,
                            errorMsg: "Polje e-mail ne smije biti prazno!",
                            hint: "e-mail"),
                        const SizedBox(height: 30),
                        Text(
                          "Password",
                          style: Theme.of(context).textTheme.headline2,
                        ),
                        const SizedBox(height: 7),
                        MyTextForm(
                            textFildController: _passController,
                            errorMsg: "Polje password ne smije biti prazno!",
                            hint: "pasword"),
                        const SizedBox(height: 20),
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
                                Provider.of<AuthProvider>(context,
                                        listen: false)
                                    .registration(
                                        _firstNameController.text,
                                        _lastNameController.text,
                                        _emailController.text,
                                        _passController.text)
                                    .then((value) {
                                  Navigator.of(context).pop();
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Text('Pažnja!'),
                                      content: Text(value
                                          ? "Uspijesno ste se registrovali !"
                                          : 'Došlo je do greške prilikom registracije, provjerite podatke i pokušajte ponovo.'),
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
                                });
                              }
                            },
                            child: const Text("Sign up",
                                style: TextStyle(
                                  fontSize: 20.0,
                                )))
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }
}
