import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zartek_machine_test/presentation/screens/authentication_screen.dart';
import 'package:zartek_machine_test/presentation/screens/home/home_screen.dart';

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          const Center(
            child: Text("Something went wrong"),
          );
        } else {
          if (snapshot.data == null) {
            return Authentication();
          } else {
            print('------------------${snapshot.data?.uid}---------------${snapshot.data?.displayName}');
            return const HomeScreen();
          }
        }
        return CircularProgressIndicator();
      },
    );
  }
}
