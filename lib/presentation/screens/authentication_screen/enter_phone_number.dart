import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:zartek_machine_test/provider/auth_provider.dart';

import '../../../custom_widgets/custom_button.dart';
import '../../../utils/toast_util.dart';
import 'otp_screen.dart';

class EnterPhoneNumber extends StatefulWidget {
  EnterPhoneNumber({super.key});

  @override
  State<EnterPhoneNumber> createState() => _EnterPhoneNumberState();
}

class _EnterPhoneNumberState extends State<EnterPhoneNumber> {
  final formKey = GlobalKey<FormState>();

  late TextEditingController numberCtrl;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    numberCtrl = TextEditingController(text: "+91");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    numberCtrl.dispose();
  }

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
                        "Enter Phone Number",
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
                        controller: numberCtrl,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter your mobile number";
                          } else if (value.length != 13) {
                            return "Enter valid Phone Number";
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
                            hintText: "Phone number",
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
                      Consumer<SignInProvider>(builder: (context, number, _) {
                        return CustomButton(
                          isLoading: number.isSendOtpLoading,
                          text: "Submit",
                          onPress: () {
                            if (formKey.currentState!.validate()) {
                              number.sendOtp(
                                  context: context, number: numberCtrl.text);
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
