import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:ecommerce_app/const/const.dart';
import 'package:ecommerce_app/firebase_authentication/firebase_instance.dart';
import 'package:ecommerce_app/page/category/cat_product_list_widget.dart';
import 'package:ecommerce_app/page/category/categories_widget.dart';
import 'package:ecommerce_app/page/category/category_page.dart';
import 'package:ecommerce_app/widget/customButton.dart';
import 'package:ecommerce_app/widget/customTextfiled.dart';
import 'package:ecommerce_app/widget/homescreen_product_widget.dart';
import 'package:ecommerce_app/widget/slider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();

  final Stream<QuerySnapshot> _categories =
      FirebaseFirestore.instance.collection('categories').snapshots();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: clr_white,
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    SizedBox(
                      width: 20.w,
                    ),
                    Row(
                      children: [
                        _searchBox(
                            controller: _searchController,
                            hintText: 'Search',
                            iconData: IconlyLight.search),
                        SizedBox(
                          width: 15.w,
                        ),
                        const Icon(
                          IconlyLight.search,
                          color: clr_n_grey,
                        ),
                        SizedBox(
                          width: 15.w,
                        ),
                        const Icon(
                          IconlyLight.notification,
                          color: clr_n_grey,
                        )
                      ],
                    ),
                    const Divider(
                      thickness: 2,
                      color: clr_n_light,
                    ),
                    const CarouselImages(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Category',
                          style: textTheme.headline4,
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed(CategoryPage.id);
                            },
                            child: Text('View All')),
                      ],
                    ),
                    Container(
                      height: 150.h,
                      child: CategoriesWidget(
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Flash Sale',
                          style: textTheme.headline4,
                        ),
                        TextButton(onPressed: () {}, child: Text('View All')),
                      ],
                    ),
                    SizedBox(
                        child: HomeScreenProductWidget(
                            stream: FireStoreDbInstance().flashSale)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '''Men's Shirt''',
                          style: textTheme.headline4,
                        ),
                        TextButton(onPressed: () {}, child: Text('View All')),
                      ],
                    ),
                    SizedBox(
                        child: HomeScreenProductWidget(
                            stream: FireStoreDbInstance().manShirt)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Women Dress',
                          style: textTheme.headline4,
                        ),
                        TextButton(onPressed: () {}, child: Text('View All')),
                      ],
                    ),
                    SizedBox(
                      child: HomeScreenProductWidget(
                        stream: FireStoreDbInstance().womenDress,
                      ),
                    ),
                    SizedBox(
                      height: 100,
                    ),
                    Stack(
                      children: [
                        Container(
                          width: 350.w,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.asset('assets/images/summer.png')),
                        ),
                        Positioned(
                          bottom: 0,
                          child: _shopNowButton('Shop Now', () {}),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 100,
                    )
                  ],
                ),
              ),
            )));
  }

  _shopNowButton(String text, Function onpressed) {
    return Container(
        decoration: BoxDecoration(
            color: clr_dark_blue, borderRadius: BorderRadius.circular(15)),
        child: Center(
          child: CupertinoButton(
              child: Text(
                text,
                style: textTheme.subtitle1,
              ),
              onPressed: () {
                onpressed();
              }),
        ));
  }

  _searchBox(
      {required TextEditingController controller,
      required String hintText,
      required IconData iconData}) {
    return SizedBox(
      width: 266.w,
      height: 46.h,
      child: TextField(
        controller: controller,
        style: textTheme.bodyText2,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: textTheme.bodyText1,
          prefixIcon: Icon(
            iconData,
            color: clr_blue,
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: clr_n_light)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: clr_blue)),
        ),
      ),
    );
  }
}
