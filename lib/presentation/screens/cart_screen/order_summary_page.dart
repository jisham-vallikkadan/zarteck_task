import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:zartek_machine_test/custom_widgets/custom_button.dart';
import 'package:zartek_machine_test/presentation/screens/home/home_screen.dart';
import 'package:zartek_machine_test/provider/item_provider.dart';

class OrderSummary extends StatelessWidget {
  const OrderSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ItemProvider>(builder: (context, cart, _) {
      var newlist = cart.itemList?.first.tableMenuList
          ?.map((element) => element.categoryDishes
              ?.where((element) => element.isCart == true)
              .toList())
          .toList();
      cart.cartList = newlist?.expand((sublist) => sublist!).toList();
      return Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: CustomButton(
            text: "Place Order",
            onPress: () {
              showDialog<void>(
                context: context,
                barrierDismissible: false, // user must tap button!
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Text(
                      'Order successfully placed!',
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 18.sp),
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: const Text(
                          'Back to Home',
                          style: TextStyle(color: Colors.green),
                        ),
                        onPressed: () async {
                          await cart.fetchItemList(context: context);
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomeScreen()),
                              (route) => false);
                          cart.cartItemCount = null;
                        },
                      ),
                    ],
                  );
                },
              );
            },
            bgColor: CupertinoColors.systemGreen,
          ),
        ),
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          backgroundColor: Colors.white,
          elevation: 10,
          centerTitle: false,
          title: Text(
            'Order Summary',
            style: TextStyle(
                color: Colors.grey,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Card(
            elevation: 2,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
              padding: const EdgeInsets.all(8),
              width: ScreenUtil().screenWidth,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: ScreenUtil().screenWidth,
                    height: 50,
                    color: Colors.green,
                    child: Text(
                      '${cart.cartList?.length ?? 0} Dishes - ${cart.totalNumberOfItems(cart.cartList!.map((element) => element!.count).toList())} Items',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.separated(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                itemBuilder: (context, index) {
                                  return cart.cartList?[index]?.isCart == true
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 5.0),
                                              child: Icon(
                                                Icons.circle,
                                                color: Colors.green,
                                                size: 12.r,
                                              ),
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
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          cart.cartList?[index]
                                                                  ?.dishName ??
                                                              "",
                                                          maxLines: 2,
                                                          style: TextStyle(
                                                              fontSize: 15.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  Text(
                                                    'INR ${cart.cartList?[index]?.dishPrice}',
                                                    style: TextStyle(
                                                        fontSize: 15.sp,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  Text(
                                                    '${cart.cartList?[index]?.dishCalories} callaries',
                                                    style: TextStyle(
                                                        fontSize: 14.sp,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Column(
                                              children: [
                                                Container(
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
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: InkWell(
                                                          onTap: () {
                                                            print('minus');
                                                            cart.cartMinus(
                                                                id: cart
                                                                        .cartList![
                                                                            index]
                                                                        ?.dishId ??
                                                                    '');
                                                          },
                                                          child: Center(
                                                            child: Text(
                                                              '-',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      16.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: InkWell(
                                                          onTap: () {
                                                            print('count');
                                                          },
                                                          child: Center(
                                                            child: Text(
                                                              '${cart.cartList?[index]?.count}',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      16.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: InkWell(
                                                          onTap: () {
                                                            print('plus');
                                                            cart.cartPlus(
                                                                id: cart
                                                                        .cartList![
                                                                            index]
                                                                        ?.dishId ??
                                                                    '');
                                                          },
                                                          child: Center(
                                                            child: Text(
                                                              '+',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      16.sp,
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
                                                Text(
                                                  'INR ${cart.dishPrice(count: cart.cartList?[index]?.count, unitPrice: cart.cartList?[index]!.dishPrice, id: cart.cartList?[index]?.dishId)}',
                                                  style: TextStyle(
                                                      fontSize: 15.sp,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )
                                      : const SizedBox();
                                },
                                separatorBuilder: (context, index) => Divider(),
                                itemCount: cart.cartList?.length ?? 0),
                          ),
                          const Divider(),
                          Row(
                            children: [
                              Expanded(
                                  child: Text(
                                'Total Amount',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500),
                              )),
                              Consumer<ItemProvider>(
                                  builder: (context, total, _) {
                                return Text(
                                  'INR ${total.totalPrice(count: cart.cartList?.map((element) => element?.prize).toList())}',
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w400),
                                );
                              })
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
