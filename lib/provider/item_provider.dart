import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:zartek_machine_test/service/item_service.dart';
import '../models/item_model.dart';

class ItemProvider with ChangeNotifier {
  bool isLoading = false;
  List<ItemModel>? itemList;
  List<CategoryDishes>? cartDish = [];

  fetchItemList({
    required BuildContext context,
  }) async {
    isLoading = true;
    itemList = (await ItemService().getItemList(
      context: context,
    ))!;
    isLoading = false;
    notifyListeners();
  }

  cartCount() {
    var newlist = itemList?.first.tableMenuList
        ?.map((element) => element.categoryDishes
            ?.where((element) => element.isCart == true)
            .toList())
        .toList();
    cartItemCount = newlist?.expand((sublist) => sublist!).toList();
    notifyListeners();
  }

  addTocart({String? id, String? menuCatId}) async {
    var newlist = itemList?.first.tableMenuList
        ?.firstWhere((element) => element.menuCategoryId == menuCatId);
    CategoryDishes? selectedDish =
        newlist?.categoryDishes?.firstWhere((element) => element.dishId == id);
    selectedDish?.isCart = true;
    selectedDish?.count = 1;
    var price = (selectedDish?.dishPrice ?? 0) * (selectedDish?.count ?? 0);
    selectedDish?.prize = price as double?;
    cartCount();
    notifyListeners();
  }

  homeItemCountPlus({String? id, String? menuCatId}) {
    CategoryDishes? selectedDish;
    var newlist = itemList?.first.tableMenuList
        ?.firstWhere((element) => element.menuCategoryId == menuCatId);
    selectedDish =
        newlist?.categoryDishes?.firstWhere((element) => element.dishId == id);
    selectedDish?.count = (selectedDish.count ?? 0) + 1;
    var price = (selectedDish?.dishPrice ?? 0) * (selectedDish?.count ?? 0);
    selectedDish?.prize = price as double?;
    notifyListeners();
  }

  homeItemCountMinus({String? id, String? menuCatId}) {
    CategoryDishes? selectedDish;
    var newlist = itemList?.first.tableMenuList
        ?.firstWhere((element) => element.menuCategoryId == menuCatId);
    selectedDish =
        newlist?.categoryDishes?.firstWhere((element) => element.dishId == id);
    print(jsonEncode(selectedDish?.count));
    if (selectedDish?.count == 1) {
      selectedDish?.isCart = false;
      notifyListeners();
    } else {
      selectedDish?.count = (selectedDish.count ?? 0) - 1;
      var price = (selectedDish?.dishPrice ?? 0) * (selectedDish?.count ?? 0);
      selectedDish?.prize = price as double?;
      notifyListeners();
    }
    cartCount();
  }

  String? dishPrice({num? unitPrice, int? count, String? id}) {
    var item = cartList?.firstWhere((element) => element?.dishId == id);
    var price = (unitPrice ?? 0) * (count ?? 0);
    item?.prize = price as double?;
    return price.toString();
  }

  String totalNumberOfItems(List<int?> count) {
    int total = 0;
    for (int i = 0; i < count.length; i++) {
      total = total + count[i]!;
    }
    print(total);
    return total.toString();
  }

  List<CategoryDishes?>? cartList;

  List<CategoryDishes?>? cartItemCount;
  cartPlus({String? id}) {
    var item = cartList?.firstWhere((element) => element?.dishId == id);
    print(jsonEncode(item?.count));
    if (item != null) {
      item.count = (item.count ?? 0) + 1;
      notifyListeners();
    }
  }

  cartMinus({String? id}) {
    var item = cartList?.firstWhere((element) => element?.dishId == id);
    print(jsonEncode(item?.count));
    if (item != null) {
      if (item.count == 1) {
        item.isCart = false;
      } else {
        item.count = (item.count ?? 0) - 1;
      }
      notifyListeners();
    }
    cartCount();
  }

  String? totalPrice({
    var count,
  }) {
    print(count);
    num? total;
    for (int i = 0; i < count!.length; i++) {
      total = (total ?? 0) + count![i]!;
    }
    print(total);
    return total.toString();
  }
}
