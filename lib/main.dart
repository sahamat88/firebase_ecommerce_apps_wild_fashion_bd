import 'package:ecommerce_app/firebase_authentication/sign_in.dart';
import 'package:ecommerce_app/firebase_authentication/sign_up.dart';
import 'package:ecommerce_app/page/address_page.dart';
import 'package:ecommerce_app/page/btm_nav_bar.dart';
import 'package:ecommerce_app/page/cart_page.dart';
import 'package:ecommerce_app/page/category/cat_product_list_widget.dart';
import 'package:ecommerce_app/page/category/category_page.dart';
import 'package:ecommerce_app/page/home_page.dart';
import 'package:ecommerce_app/firebase_authentication/user_info.dart';
import 'package:ecommerce_app/page/product_details_page.dart';
import 'package:ecommerce_app/page/profile_page.dart';
import 'package:ecommerce_app/page/slpash_screen.dart';
import 'package:ecommerce_app/page/wishlist.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Set the fit size (Find your UI design, look at the dimensions of the device screen and fill it in,unit in dp)
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'E-Commerce App',
            // You can use the library anywhere in the app even in theme
            theme: ThemeData(
              primarySwatch: Colors.blue,
              textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
            ),
            home: child,
            initialRoute: '/',
            routes: {
              CatProductListWidget.id: (context) => CatProductListWidget(),
              ProductDetailsPage.id: (context) => ProductDetailsPage(),
              CategoryPage.id: (context) => CategoryPage(),
              CartPage.id: (context) => CartPage(),
              WishListPage.id: (context) => WishListPage(),
              AddressPage.id: (context) => AddressPage()
            },
          );
        },
        child: SplashScreen());
  }
}
