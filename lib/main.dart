import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:zartek_machine_test/presentation/screens/authentication_screen.dart';
import 'package:zartek_machine_test/presentation/screens/home/home_screen.dart';
import 'package:zartek_machine_test/presentation/wrapper.dart';
import 'package:zartek_machine_test/provider/auth_provider.dart';
import 'package:zartek_machine_test/provider/item_provider.dart';

import 'firebase_options.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 800),
        minTextAdapt: true,
        splitScreenMode: true,
        child: MultiProvider(
            providers: [
              ChangeNotifierProvider<ItemProvider>(
                  create: (_) => ItemProvider()),
              ChangeNotifierProvider<SignInProvider>(
                  create: (_) => SignInProvider()),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true,
              ),
              home: AuthWrapper(),
            )));
  }
}
