import 'dart:ffi';

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:ecommerce_app/const/const.dart';
import 'package:ecommerce_app/widget/customButton.dart';
import 'package:ecommerce_app/widget/slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WishListPage extends StatefulWidget {
  const WishListPage({super.key});
  static const id = '/wishlist-page';

  @override
  State<WishListPage> createState() => _WishListPageState();
}

class _WishListPageState extends State<WishListPage> {
  final _currentUserStream = FirebaseFirestore.instance
      .collection('users-wishlist-items')
      .doc(FirebaseAuth.instance.currentUser!.email)
      .collection('items')
      .orderBy('productName', descending: false)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: clr_white,
          body: Column(
            children: [
              Container(
                padding: EdgeInsets.only(bottom: 5, left: 10, top: 5),
                alignment: Alignment.bottomLeft,
                height: 40.h,
                width: double.infinity,
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(IconlyLight.arrowLeft)),
                    Text(
                      'Wish List',
                      style: textTheme.headline4,
                    ),
                  ],
                ),
              ),
              Divider(
                thickness: 2,
              ),
              Container(
                child: Expanded(
                  child: StreamBuilder(
                    stream: _currentUserStream,
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text('Something went wrong');
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Text("Loading");
                      }

                      return Container(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        width: 343.w,
                        child: ListView.separated(
                          separatorBuilder: (context, index) => SizedBox(
                            height: 20,
                          ),
                          scrollDirection: Axis.vertical,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            DocumentSnapshot data = snapshot.data!.docs[index];
                            return Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  border:
                                      Border.all(color: clr_n_light, width: 2)),
                              height: 120.h,
                              child: Stack(
                                children: [
                                  Container(
                                    height: 100,
                                    width: 80,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(
                                      data['productImage'],
                                    ))),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Positioned(
                                      right: 80,
                                      child: Container(
                                        width: 200,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              data['productName'],
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: clr_dark_blue),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              '\$${data['productPrice']}',
                                              style: TextStyle(
                                                color: clr_blue,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                              ),
                                            )
                                          ],
                                        ),
                                      )),
                                  Positioned(
                                      right: 4,
                                      bottom: 0,
                                      child: CupertinoButton(
                                        onPressed: () {
                                          addToCart(data);
                                          customToast(
                                              'Add To Cart Successfully!!',
                                              context);
                                        },
                                        child: Container(
                                            alignment: Alignment.center,
                                            height: 30.h,
                                            width: 60,
                                            decoration: BoxDecoration(
                                                color: clr_blue,
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: Icon(
                                              Icons.add_shopping_cart,
                                              color: clr_white,
                                              size: 30,
                                            )),
                                      )),
                                  Positioned(
                                    right: 10,
                                    top: 0,
                                    child: Row(
                                      children: [
                                        CupertinoButton(
                                            child: Icon(
                                              Icons.close,
                                              color: clr_blue,
                                              size: 30,
                                            ),
                                            onPressed: () {
                                              FirebaseFirestore.instance
                                                  .collection(
                                                      'users-wishlist-items')
                                                  .doc(FirebaseAuth.instance
                                                      .currentUser!.email)
                                                  .collection('items')
                                                  .doc(data.id)
                                                  .delete();
                                              customToast(
                                                  'Remove Successfully!!',
                                                  context);
                                            })
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          )),
    );
  }

  qtyButton(IconData iconData) {
    return CupertinoButton(
      onPressed: () {},
      child: Container(
        height: 30,
        width: 35,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(2),
            border: Border.all(color: clr_n_light, width: 2)),
        child: Icon(iconData, color: clr_blue),
      ),
    );
  }
}
