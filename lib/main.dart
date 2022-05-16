import 'package:flutter/material.dart';

import 'auth.dart';
import 'home.dart';

Future<void> main() async {
  //TODO: invocar o FlutterBinding e FirebaseApp antes do runApp

  runApp(const AppWidget());
}

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Fire App",
      initialRoute: "/",
      routes: {
        "/": (context) => const Home(),
        "/sign-up": (context) => const AuthGate(authMode: AuthMode.signUp),
        "/sign-in": (context) => const AuthGate(authMode: AuthMode.signIn),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
