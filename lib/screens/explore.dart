// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:social_media/AuthClass/auth_class.dart';
import 'package:social_media/screens/signin_screen.dart';

class Explore extends StatefulWidget {
  const Explore({super.key});

  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: () async {
              bool isSignout = await AuthClass().signOutFromGoogle();
              if (isSignout == true) {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SigninScreen()));
              }
            },
            child: const Text("Signout")),
      ),
    );
  }
}
