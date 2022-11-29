import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

import 'package:google_fonts/google_fonts.dart';

const Color clr_blue = Color(0XFF40BFFF);
const Color clr_white = Color(0XFFFFFFFF);
const Color clr_dark_blue = Color(0XFF223263);
const Color clr_n_grey = Color(0XFF9098B1);
const Color clr_n_light = Color(0XFFEBF0FF);

TextTheme textTheme = TextTheme(
  headline1: GoogleFonts.poppins(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      letterSpacing: 0.25,
      color: clr_blue),
  headline2: GoogleFonts.poppins(
      fontSize: 60, fontWeight: FontWeight.w300, letterSpacing: -0.5),
  headline3: GoogleFonts.poppins(fontSize: 48, fontWeight: FontWeight.w400),
  headline4: GoogleFonts.poppins(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      letterSpacing: 0.25,
      color: clr_dark_blue),
  headline5: GoogleFonts.poppins(
      color: clr_n_grey, fontSize: 14, fontWeight: FontWeight.w700),
  headline6: GoogleFonts.poppins(
      color: clr_white,
      fontSize: 17,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.15),
  subtitle1: GoogleFonts.poppins(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.15,
      color: clr_n_grey),
  subtitle2: GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
  ),
  bodyText1: GoogleFonts.poppins(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.15,
      color: clr_n_grey),
  bodyText2: GoogleFonts.poppins(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      color: clr_n_grey,
      letterSpacing: 0.25),
  button: GoogleFonts.poppins(
      fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),
  caption: GoogleFonts.poppins(
      fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
  overline: GoogleFonts.poppins(
      fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
);

customToast(String title, context) {
  return showToast('$title',
      context: context,
      animation: StyledToastAnimation.scale,
      reverseAnimation: StyledToastAnimation.fade,
      position: StyledToastPosition.bottom,
      animDuration: Duration(seconds: 1),
      duration: Duration(seconds: 2),
      curve: Curves.elasticOut,
      reverseCurve: Curves.linear,
      textStyle: TextStyle(color: clr_white),
      backgroundColor: clr_dark_blue);
}

Future addToCart(var data) async {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var currentUser = _auth.currentUser;
  CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection("users-cart-items");
  return _collectionRef.doc(currentUser!.email).collection("items").doc().set({
    "productName": data["productName"],
    "productPrice": data["productPrice"],
    "productImage": data["productImage"],
  }).then((value) => print('Add to cart'));
}

Future addToWishlist(var data) async {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var currentUser = _auth.currentUser;
  CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection("users-wishlist-items");
  return _collectionRef.doc(currentUser!.email).collection("items").doc().set({
    "productName": data["productName"],
    "productPrice": data["productPrice"],
    "productImage": data["productImage"],
  }).then((value) => print("Add to wishlist "));
}
