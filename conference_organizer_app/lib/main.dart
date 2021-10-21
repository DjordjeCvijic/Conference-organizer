import 'package:conference_organizer_app/providers/auth_provider.dart';
import 'package:conference_organizer_app/screens/login_screen.dart';
import 'package:conference_organizer_app/screens/main_screen.dart';
import 'package:conference_organizer_app/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "./globals.dart" as globals;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.grey[900],
          textTheme: const TextTheme(
              headline1: TextStyle(
                  //za veliko login,registration
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
              headline2: TextStyle(
                  //za iznad text fild-ova
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white))),
      home: ChangeNotifierProvider(
        create: (context) => AuthProvider(),
        child: const LoginScreen(),
      ),
      routes: {
        globals.registrationScreenRoute: (ctx) => const RegistrationScreen(),
        globals.mainScreenRoute: (ctx) => const MainScreen()
      },
    );
  }
}
