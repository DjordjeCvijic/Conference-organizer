import 'package:conference_organizer_app/providers/auth_provider.dart';
import 'package:conference_organizer_app/screens/login_screen.dart';
import 'package:conference_organizer_app/screens/navigation_drawer.dart';
import 'package:conference_organizer_app/screens/registration_screen.dart';
import 'package:conference_organizer_app/screens/show_conference_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "./globals.dart" as globals;
import 'screens/session_editing_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Conference Organizer',
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
                color: Colors.white),
            headline3: TextStyle(
                //za naslove za svaku stanicu
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          )),
      home: ChangeNotifierProvider(
        create: (context) => AuthProvider(),
        child: const LoginScreen(),
      ),
      routes: {
        globals.registrationScreenRoute: (ctx) => const RegistrationScreen(),
        globals.navigatorDrawerRoute: (ctx) => const NavigationDrawer(),
        globals.sessionEditingScreenRoute: (ctx) =>
            const SessionEditingScreen(),
        globals.showConferenceSccreeRoute: (ctx) => const ShowConferenceScreen()
      },
    );
  }
}
