import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(0),
      children: [
        Container(
          alignment: Alignment.center,
          height: 200.h,
          color: Colors.green,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                backgroundImage: AssetImage('assets/images/googel.png'), //Text
              ),
              Text(
                "Muhammed Naseem",
                style: TextStyle(fontSize: 18.sp, color: Colors.black),
              ),
              Text(
                "ID :401",
                style: TextStyle(fontSize: 18.sp, color: Colors.black),
              ),
            ],
          ),
        ),
        ListTile(
          leading: const Icon(Icons.logout),
          title: const Text('Log Out'),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
