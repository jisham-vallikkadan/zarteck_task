import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:zartek_machine_test/utils/toast_util.dart';

class NetworkHelper {
  Future<http.Response?> getRequest({
    required BuildContext context,
    required String url,
  }) async {
    http.Response? response;
    Map<String, String>? headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    try {
      response = await http.get(
        Uri.parse(url),
        headers: headers,
      );
      debugPrint("$url---$headers-->${response.body}======");
    } on SocketException {
      ToastUtil.show("Please check your internet connection");
    } catch (e) {
      ToastUtil.show(e.toString());
    }
    return response;
  }
}
