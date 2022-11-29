import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/const/const.dart';
import 'package:ecommerce_app/page/btm_nav_bar.dart';
import 'package:ecommerce_app/page/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CrudFirebase {
  addUser({
    required BuildContext context,
    required String name,
    required String selectGender,
    required String phone,
    required String dateBirth,
    required String age,
    required String address,
    required String image,
  }) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return users
        .doc(FirebaseAuth.instance.currentUser!.email)
        .set(
          {
            'name': name,
            'phone': phone,
            'dob': dateBirth,
            'gender': selectGender,
            'age': age,
            'address': address,
            'image': image
          },
        )
        .then((value) => Navigator.push(
            context, CupertinoPageRoute(builder: (context) => BtmNavBarPage())))
        .catchError((error) => print("Failed to merge data: $error"));
  }

  updateUser(
      {required BuildContext context,
      required String name,
      required String selectGender,
      required String phone,
      required String dateBirth,
      required String age,
      required String address}) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return users
        .doc(FirebaseAuth.instance.currentUser!.email)
        .update(
          {
            'name': name,
            'phone': phone,
            'dob': dateBirth,
            'gender': selectGender,
            'age': age,
            'address': address
          },
        )
        .then((value) =>
            customToast('Update your profile successfully!!', context))
        .catchError((error) => print("Failed to merge data: $error"));
  }

  addNewAddress({
    required BuildContext context,
    required String name,
    required String phone,
    required String street_address,
    required String city,
    required String division,
    required String zip_code,
  }) async {
    CollectionReference addressRef =
        FirebaseFirestore.instance.collection('users-address');

    return addressRef
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection('address')
        .doc()
        .set(
          {
            'name': name,
            'phone': phone,
            'street_address': street_address,
            'city': city,
            'division': division,
            'zip_code': zip_code,
          },
        )
        .then((value) =>
            customToast('added new asddress successfully!!', context))
        .catchError((error) => print("Failed to merge data: $error"));
  }

  editAddress({
    required BuildContext context,
    required String name,
    required String phone,
    required String street_address,
    required String city,
    required String division,
    required String zip_code,
  }) async {
    CollectionReference addressRef =
        FirebaseFirestore.instance.collection('users-address');

    return addressRef
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection('address')
        .doc()
        .update(
          {
            'name': name,
            'phone': phone,
            'street_address': street_address,
            'city': city,
            'division': division,
            'zip_code': zip_code,
          },
        )
        .then((value) =>
            customToast('added new asddress successfully!!', context))
        .catchError((error) => print("Failed to merge data: $error"));
  }
}
