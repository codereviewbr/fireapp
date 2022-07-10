import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'firebase_messaging_service.dart';
import 'profile.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

enum AuthMode { signUp, signIn }

class _HomeState extends State<Home> {
  final _currentUser = FirebaseAuth.instance.currentUser;
  final _messageService = FirebaseMessagingService();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await _messageService.init();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_currentUser != null) {
      return const Profile();
    } else {
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
}
