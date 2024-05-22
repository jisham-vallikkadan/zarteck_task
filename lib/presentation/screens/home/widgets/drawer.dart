import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zartek_machine_test/presentation/screens/authentication_screen.dart';

import '../../../../service/auth_service.dart';

class AppDrawer extends StatelessWidget {
  AppDrawer({super.key});
  final auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        return ListView(
          padding: const EdgeInsets.all(0),
          children: [
            Container(
              alignment: Alignment.center,
              height: 200.h,
              decoration: const BoxDecoration(
                  color: Color(0xFF399123),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(5),
                      bottomRight: Radius.circular(5))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage:
                        NetworkImage(snapshot.data?.photoURL ?? ''), //Text
                  ),
                  Text(
                    "${snapshot.data?.displayName}",
                    style: TextStyle(fontSize: 18.sp, color: Colors.black),
                  ),
                  Text(
                    "ID :${snapshot.data?.uid}",
                    style: TextStyle(fontSize: 18.sp, color: Colors.black),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Log Out'),
              onTap: () async {
                await auth.signout();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => Authentication()),
                    (route) => false);
              },
            ),
          ],
        );
      },
    );
  }
}
