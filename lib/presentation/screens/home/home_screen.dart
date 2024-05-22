import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:zartek_machine_test/presentation/screens/cart_screen/order_summary_page.dart';
import 'package:zartek_machine_test/provider/item_provider.dart';

import 'widgets/drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ItemProvider>(context, listen: false)
        .fetchItemList(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ItemProvider>(builder: (context, item, _) {
      return Scaffold(
        drawer: const Drawer(
          child: AppDrawer(),
        ),
        appBar: AppBar(
          actions: [
            Consumer<ItemProvider>(builder: (context, cart, _) {
              return Stack(
                children: [
                  IconButton(
                      onPressed: (cart.cartItemCount?.length ?? 0) > 0
                          ? () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const OrderSummary(),
                                  ));
                            }
                          : null,
                      icon: const Icon(
                        Icons.shopping_cart,
                        size: 30,
                      )),
                  (cart.cartItemCount?.length ?? 0) > 0
                      ? Positioned(
                          right: 5,
                          child: CircleAvatar(
                            radius: 10,
                            backgroundColor: Colors.red,
                            child: Center(
                              child: Text(
                                '${cart.cartItemCount?.length ?? 0}',
                                style: const TextStyle(
                                    fontSize: 10, color: Colors.white),
                              ),
                            ),
                          ),
                        )
                      : SizedBox(),
                ],
              );
            }),
          ],
        ),
        body: item.isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.green,
                ),
              )
            : DefaultTabController(
                length: item.itemList?.first.tableMenuList?.length ?? 0,
                child: Column(
                  children: [
                    TabBar(
                        physics: const ClampingScrollPhysics(),
                        // automaticIndicatorColorAdjustment: true,
                        // isScrollable: true,
                        indicatorSize: TabBarIndicatorSize.label,
                        indicatorWeight: 3.5,
                        labelPadding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        indicatorColor: Colors.red,
                        labelColor: Colors.red,
                        unselectedLabelColor: Colors.grey,
                        // tabAlignment: TabAlignment.start,
                        tabs: List.generate(
                          item.itemList?.first.tableMenuList?.length ?? 0,
                          (index) {
                            return Text(
                              item.itemList?.first.tableMenuList![index]
                                      .menuCategory ??
                                  "",
                              style: TextStyle(
                                  fontSize: 14.sp, fontWeight: FontWeight.w700),
                            );
                          },
                        )),
                    Expanded(
                      child: TabBarView(
                        children: List.generate(
                          item.itemList?.first.tableMenuList?.length ?? 0,
                          (index) {
                            return ListView.separated(
                                padding: const EdgeInsets.all(16),
                                itemBuilder: (context, index1) {
                                  var items = item
                                      .itemList
                                      ?.first
                                      .tableMenuList![index]
                                      .categoryDishes![index1];
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.circle,
                                        color: Colors.green,
                                        size: 12.r,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    items?.dishName ?? "",
                                                    maxLines: 2,
                                                    style: TextStyle(
                                                        fontSize: 15.sp,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                )
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    'INR ${items?.dishPrice ?? ''}',
                                                    style: TextStyle(
                                                        fontSize: 15.sp,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                                Text(
                                                  '${items?.dishCalories ?? ""} Calories',
                                                  style: TextStyle(
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              items?.dishDescription ?? "",
                                              maxLines: 3,
                                              style: TextStyle(
                                                  color: CupertinoColors
                                                      .inactiveGray,
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Visibility(
                                              visible: items?.isCart == false
                                                  ? true
                                                  : false,
                                              replacement: Container(
                                                alignment: Alignment.center,
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10),
                                                width: 125.w,
                                                height: 40.h,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                    color: CupertinoColors
                                                        .activeGreen),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: InkWell(
                                                        hoverColor: Colors.transparent,
                                                        splashColor: Colors.transparent,
                                                        highlightColor:
                                                        Colors.transparent,
                                                        onTap: () {
                                                          item.homeItemCountMinus(
                                                              id: items?.dishId,
                                                              menuCatId: item
                                                                  .itemList
                                                                  ?.first
                                                                  .tableMenuList![
                                                                      index]
                                                                  .menuCategoryId);
                                                        },
                                                        child: Center(
                                                          child: Text(
                                                            '-',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 16.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Center(
                                                        child: Text(
                                                          '${items?.count ?? 0}',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white,
                                                              fontSize: 16.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: InkWell(
                                                        hoverColor: Colors.transparent,
                                                        splashColor: Colors.transparent,
                                                        highlightColor:
                                                        Colors.transparent,
                                                        onTap: () {
                                                          item.homeItemCountPlus(
                                                              id: items?.dishId,
                                                              menuCatId: item
                                                                  .itemList
                                                                  ?.first
                                                                  .tableMenuList![
                                                                      index]
                                                                  .menuCategoryId);
                                                        },
                                                        child: Center(
                                                          child: Text(
                                                            '+',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 16.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              child: InkWell(
                                                hoverColor: Colors.transparent,
                                                splashColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () {
                                                  item.addTocart(
                                                      id: items?.dishId,
                                                      menuCatId: item
                                                          .itemList
                                                          ?.first
                                                          .tableMenuList![index]
                                                          .menuCategoryId);
                                                },
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  margin: const EdgeInsets
                                                      .symmetric(vertical: 10),
                                                  width: 125.w,
                                                  height: 40.h,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                      color: CupertinoColors
                                                          .activeGreen),
                                                  child: Text(
                                                    'Add',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16.sp,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            (items?.addonCat?.length ?? 0) > 0
                                                ? Text(
                                                    "Customizations availabl ",
                                                    style: TextStyle(
                                                        color: Colors.red,
                                                        fontSize: 14.sp,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  )
                                                : const SizedBox(),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(left: 10),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: Colors.grey,
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                  items?.dishImage ?? "",
                                                ),
                                                fit: BoxFit.fill)),
                                        width: 80.w,
                                        height: 80.w,
                                      )
                                    ],
                                  );
                                },
                                separatorBuilder: (context, index) =>
                                    const Divider(),
                                itemCount: item
                                        .itemList
                                        ?.first
                                        .tableMenuList![index]
                                        .categoryDishes
                                        ?.length ??
                                    0);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      );
    });
  }
}
