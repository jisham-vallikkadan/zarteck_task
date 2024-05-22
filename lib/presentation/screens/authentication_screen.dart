import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zartek_machine_test/presentation/screens/home/home_screen.dart';

import '../../custom_widgets/custom_button.dart';

class Authentication extends StatelessWidget {
  const Authentication({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: ScreenUtil().screenWidth,
        height: ScreenUtil().screenHeight,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image(
                image: const AssetImage(
                  'assets/images/firebase.png',
                ),
                width: 200.w,
                height: 150.h,
              ),
              Column(
                children: [
                  CustomButton(
                    text: 'Goggel',
                    onPress: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>const HomeScreen(),
                          ));
                    },
                    leftIcon: const CircleAvatar(
                      radius: 15,
                      backgroundImage: AssetImage('assets/images/googel.png'),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  CustomButton(
                    bgColor: Colors.green,
                    text: 'Phone',
                    onPress: () {},
                    leftIcon: const Icon(
                      Icons.phone,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
