import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/firebase_authentication/sign_in.dart';
import 'package:ecommerce_app/const/const.dart';
import 'package:ecommerce_app/page/btm_nav_bar.dart';
import 'package:ecommerce_app/page/home_page.dart';
import 'package:ecommerce_app/firebase_authentication/user_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  signUp(String email, String password, context) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      var authCredential = credential.user;

      if (authCredential!.uid.isNotEmpty) {
        Navigator.push(
            context, CupertinoPageRoute(builder: (_) => UserInfoPage()));
      } else {
        customToast("Somthing is wrong", context);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        customToast('The password provided is too weak.', context);
      } else if (e.code == 'email-already-in-use') {
        customToast('Email already exists', context);
      }
    } catch (e) {
      print(e);
    }
  }

  signIn(String email, String password, context) async {
    String uid;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    try {
      UserCredential credential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      var authCredential = credential.user;

      if (authCredential!.uid.isNotEmpty) {
        sharedPreferences.setString('uid', authCredential.uid);
        Navigator.push(
            context, CupertinoPageRoute(builder: (_) => BtmNavBarPage()));
      } else {
        customToast(
            "Invalid email or password, please corect and try again ", context);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        customToast('No user found our record', context);
      } else if (e.code == 'wrong-password') {
        customToast('Invalid password ', context);
      }
    } catch (e) {
      print(e);
    }
  }
}
