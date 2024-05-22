import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:zartek_machine_test/provider/auth_provider.dart';

import '../../../custom_widgets/custom_button.dart';
import '../home/home_screen.dart';

class OtpScreen extends StatelessWidget {
  final String? verificationId;
  final String? number;
  OtpScreen({super.key, this.verificationId, this.number});

  TextEditingController otpCtrl = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: SizedBox(
              height: ScreenUtil().screenHeight - ScreenUtil().statusBarHeight,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    // vertical: 10
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 77.h,
                      ),
                      SizedBox(
                        height: 75.h,
                      ),
                      Text(
                        "Enter the OTP sent to your phone ${number ?? ""}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color(0xFF1C1C1C),
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 39.h,
                      ),
                      TextFormField(
                        cursorColor: Colors.black,
                        style: TextStyle(
                            fontFamily: "Manrope",
                            color: const Color(0xFF1E1E1E),
                            fontWeight: FontWeight.w300,
                            fontSize: 16.sp),
                        controller: otpCtrl,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter Otp";
                          } else if (value.length != 6) {
                            return "Enter valid Otp";
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                            isDense: false,
                            errorMaxLines: 4,
                            counter: const SizedBox.shrink(),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 5),
                            constraints: BoxConstraints(minHeight: 65.h),
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                            suffixIconConstraints:
                                BoxConstraints(maxHeight: 65.h),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                    const BorderSide(color: Colors.black)),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                    const BorderSide(color: Colors.red)),
                            focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                    const BorderSide(color: Color(0xFFF0EFEF))),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                ))),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Consumer<SignInProvider>(builder: (context, otp, _) {
                        return CustomButton(
                          text: "Submit",
                          isLoading: otp.isGoogelLoading,
                          onPress: () async {
                            if (formKey.currentState!.validate()) {
                              var user = await otp.verifyOtp(
                                  context: context,
                                  otp: otpCtrl.text,
                                  verificationId: verificationId!);
                              if (user != null) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const HomeScreen(),
                                    ));
                              } else {}
                            } else {
                              print('enter otp');
                            }
                          },
                        );
                      }),
                      SizedBox(
                        height: 70.h,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
