import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../service/auth_service.dart';

class SignInProvider with ChangeNotifier{
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
}