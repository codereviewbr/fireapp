import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

enum AuthMode { signUp, signIn }

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    //TODO: verificar se o usuário está autenticado
    // e carregar a tela Profile ou a tela Home
    // if (_currentUser != null) {
    //   return const Profile();
    // } else {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Fireapp"),
          centerTitle: true,
        ),
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Image.asset(
                    "assets/images/logo.png",
                  ),
                ),
                ElevatedButton(
                  child: const Text("Sign up"),
                  onPressed: () {
                    Navigator.pushNamed(context, "/sign-up");
                  },
                ),
                ElevatedButton(
                  child: const Text("Sign in"),
                  onPressed: () {
                    Navigator.pushNamed(context, "/sign-in");
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
    // }
  }
}
