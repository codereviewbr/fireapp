import 'package:fireapp/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class AuthGate extends StatefulWidget {
  final AuthMode authMode;
  const AuthGate({
    Key? key,
    required this.authMode,
  }) : super(key: key);

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  final _auth = FirebaseAuth.instance;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool isLoading = false;

  void setIsLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.authMode.name == "signUp" ? "Sign up" : "Sign in",
          ),
        ),
        body: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: const InputDecoration(labelText: "Email"),
                  controller: _emailController,
                ),
                TextField(
                  decoration: const InputDecoration(labelText: "Password"),
                  controller: _passwordController,
                ),
                ElevatedButton(
                  onPressed: isLoading
                      ? null
                      : () async {
                          if (widget.authMode.name == "signUp") {
                            setIsLoading();
                            try {
                              _auth.createUserWithEmailAndPassword(
                                email: _emailController.text,
                                password: _passwordController.text,
                              );

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Profile()));
                              ScaffoldSnackbar.of(context)
                                  .show('New account created!');
                            } on FirebaseAuthException catch (e) {
                              ScaffoldSnackbar.of(context).show(e.message!);
                            } finally {
                              setIsLoading();
                            }
                          } else {
                            setIsLoading();
                            try {
                              _auth.signInWithEmailAndPassword(
                                email: _emailController.text,
                                password: _passwordController.text,
                              );

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Profile()));
                              ScaffoldSnackbar.of(context)
                                  .show('User logged in!');
                            } on FirebaseAuthException catch (e) {
                              ScaffoldSnackbar.of(context).show(e.message!);
                            } finally {
                              setIsLoading();
                            }
                          }
                        },
                  child: isLoading
                      ? const SizedBox(
                          width: 25,
                          height: 25,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : Text(
                          widget.authMode.name == "signUp"
                              ? "Sign up"
                              : "Sign in",
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ScaffoldSnackbar {
  final BuildContext _context;
  const ScaffoldSnackbar(this._context);

  factory ScaffoldSnackbar.of(BuildContext context) {
    return ScaffoldSnackbar(context);
  }

  void show(String message) {
    ScaffoldMessenger.of(_context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }
}
