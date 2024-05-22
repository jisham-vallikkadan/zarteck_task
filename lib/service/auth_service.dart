import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../utils/toast_util.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return null; // The user canceled the sign-in
      }
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      return userCredential;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<dynamic> verifyOtP(
      {required String verificationId, required String otp}) async {
    try {
      final cred = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: otp);
      await FirebaseAuth.instance.signInWithCredential(cred);
      return cred;
    } catch (e) {
      log(e.toString());
    }
  }

  Future sendOtp(
      {String? number,
      required void Function(String, int?) codeSent,
      required void Function(FirebaseAuthException) verificationFailed}) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: number,
      verificationCompleted: (phoneAuthCredential) {
        ToastUtil.show(phoneAuthCredential.toString());
      },
      verificationFailed:verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: (verificationId) {
        ToastUtil.show("Time Out");
      },
    );
  }

  Future<void> signout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      log("Something went wrong");
    }
  }
}
