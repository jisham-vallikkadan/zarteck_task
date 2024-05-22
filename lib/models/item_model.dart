class ItemModel {
  String? restaurantId;
  List<TableMenuList>? tableMenuList;

  ItemModel({this.restaurantId, this.tableMenuList});

  ItemModel.fromJson(Map<String, dynamic> json) {
    restaurantId = json['restaurant_id'];
    if (json['table_menu_list'] != null) {
      tableMenuList = <TableMenuList>[];
      json['table_menu_list'].forEach((v) {
        tableMenuList!.add(new TableMenuList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['restaurant_id'] = restaurantId;
    if (tableMenuList != null) {
      data['table_menu_list'] =
          tableMenuList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TableMenuList {
  String? menuCategory;
  String? menuCategoryId;
  List<CategoryDishes>? categoryDishes;

  TableMenuList({this.menuCategory, this.menuCategoryId, this.categoryDishes});

  TableMenuList.fromJson(Map<String, dynamic> json) {
    menuCategory = json['menu_category'];
    menuCategoryId = json['menu_category_id'];
    if (json['category_dishes'] != null) {
      categoryDishes = <CategoryDishes>[];
      json['category_dishes'].forEach((v) {
        categoryDishes!.add(new CategoryDishes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['menu_category'] = menuCategory;
    data['menu_category_id'] = menuCategoryId;
    if (categoryDishes != null) {
      data['category_dishes'] =
          categoryDishes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoryDishes {
  String? dishId;
  String? dishName;
  String? dishImage;
  String? dishDescription;
  String? nexturl;
  int? dishType;
  num? dishCalories;
  num? dishPrice;
  List<AddonCat>? addonCat;
  bool? isCart=false;
  int? count;
  double? prize;


  CategoryDishes(
      {this.dishId,
        this.dishName,
        this.dishImage,
        this.dishDescription,
        this.nexturl,
        this.dishType,
        this.dishCalories,
        this.dishPrice,
        this.isCart,
        this.count,
        this.prize,
        this.addonCat});

  CategoryDishes.fromJson(Map<String, dynamic> json) {
    dishId = json['dish_id'];
    dishName = json['dish_name'];
    dishImage = json['dish_image'];
    dishDescription = json['dish_description'];
    nexturl = json['nexturl'];
    dishType = json['dish_Type'];
    dishCalories = json['dish_calories'];
    dishPrice = json['dish_price'];
    if (json['addonCat'] != null) {
      addonCat = <AddonCat>[];
      json['addonCat'].forEach((v) {
        addonCat!.add(new AddonCat.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['dish_id'] = dishId;
    data['dish_name'] = dishName;
    data['dish_image'] = dishImage;
    data['dish_description'] = dishDescription;
    data['nexturl'] = nexturl;
    data['dish_Type'] = dishType;
    data['dish_calories'] = dishCalories;
    data['dish_price'] = dishPrice;
    if (addonCat != null) {
      data['addonCat'] = addonCat!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AddonCat {
  String? addonCategory;

  AddonCat({this.addonCategory});

  AddonCat.fromJson(Map<String, dynamic> json) {
    addonCategory = json['addon_category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['addon_category'] = addonCategory;
    return data;
  }
}
