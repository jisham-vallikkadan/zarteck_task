import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../models/item_model.dart';
import '../utils/toast_util.dart';
import 'network_helper.dart';

class ItemService {
  Future<List<ItemModel>?> getItemList({
    required BuildContext context,
  }) async {
    http.Response? response;
    response = await NetworkHelper().getRequest(
      context: context,
      url: "https://run.mocky.io/v3/eed9349e-db58-470c-ae8c-a12f6f46c207",
    );

    if (response!.statusCode == 200) {
      final List<dynamic> items = jsonDecode(response.body);
      return items.map((json) => ItemModel.fromJson(json)).toList();
    } else {
      ToastUtil.show("Server Error Please try After sometime");
      debugPrint(response.body);
    }
  }
}
