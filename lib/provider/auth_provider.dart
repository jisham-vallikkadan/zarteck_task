import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../presentation/screens/authentication_screen/otp_screen.dart';
import '../service/auth_service.dart';
import '../utils/toast_util.dart';

class SignInProvider with ChangeNotifier {
  bool isGoogelLoading = false;
  Future<UserCredential?> signWithGoogel({
    required BuildContext context,
  }) async {
    isGoogelLoading = true;
    notifyListeners();
    UserCredential? userCredential = await AuthService().signInWithGoogle()!;
    isGoogelLoading = false;
    notifyListeners();
    return userCredential;
  }

  Future<dynamic> verifyOtp(
      {required BuildContext context,
      required String verificationId,
      required String otp}) async {
    isGoogelLoading = true;
    notifyListeners();
    var userCredential =
        await AuthService().verifyOtP(verificationId: verificationId, otp: otp);
    isGoogelLoading = false;
    notifyListeners();
    return userCredential;
  }

  bool isSendOtpLoading = false;
  sendOtp({required BuildContext context, required String number}) async {
    isSendOtpLoading = true;
    notifyListeners();
    await AuthService().sendOtp(
        number: number,
        codeSent: (
          verificationId,
          forceResendingToken,
        ) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OtpScreen(
                  verificationId: verificationId,
                  number: number,
                ),
              ));
        },
        verificationFailed: (error) {
          isSendOtpLoading = false;
          notifyListeners();
          ToastUtil.show(error.toString());
        });
    // isSendOtpLoading = false;
    // notifyListeners();
  }
}
