import 'dart:async';

import 'package:ecommerce_app/const/const.dart';
import 'package:ecommerce_app/firebase_authentication/sign_in.dart';
import 'package:ecommerce_app/page/btm_nav_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? userUid;
  Future getUid() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    userUid = sharedPreferences.getString('uid');
  }

  @override
  void initState() {
    getUid().whenComplete(() {
      Timer(
          Duration(seconds: 3),
          () => Navigator.pushReplacement(
              context,
              CupertinoPageRoute(
                  builder: (_) =>
                      userUid == null ? SignInPage() : BtmNavBarPage())));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: clr_blue,
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Wild Hue Fashion",
                    style: GoogleFonts.josefinSans(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: clr_n_light)),
                SizedBox(
                  height: 20.h,
                ),
                Image.asset(
                  'assets/icons/logo.png',
                  color: clr_white,
                  fit: BoxFit.cover,
                  width: 100,
                ),
                SizedBox(
                  height: 20.h,
                ),
                CircularProgressIndicator(
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
