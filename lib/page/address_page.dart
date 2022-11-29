import 'dart:ffi';

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:ecommerce_app/const/const.dart';
import 'package:ecommerce_app/firebase_db/firebase_crud.dart';
import 'package:ecommerce_app/widget/customButton.dart';
import 'package:ecommerce_app/widget/customTextfiled.dart';
import 'package:ecommerce_app/widget/slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({super.key});
  static const id = '/address-page';

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  final _currentUserStream = FirebaseFirestore.instance
      .collection('users-address')
      .doc(FirebaseAuth.instance.currentUser!.email)
      .collection('address')
      .snapshots();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _streetAddressController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _divisonController = TextEditingController();
  TextEditingController _zipController = TextEditingController();

  clearText() {
    _nameController.clear();
    _phoneController.clear();
    _streetAddressController.clear();
    _cityController.clear();
    _divisonController.clear();
    _zipController.clear();
  }

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
                      'Address',
                      style: textTheme.headline4,
                    ),
                  ],
                ),
              ),
              Divider(
                thickness: 2,
              ),
              DottedBorder(
                strokeWidth: 3,
                color: clr_dark_blue.withOpacity(0.30),
                borderType: BorderType.RRect,
                dashPattern: [1, 5],
                strokeCap: StrokeCap.square,
                radius: Radius.circular(12),
                padding: EdgeInsets.all(6),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  child: Container(
                    height: 150.h,
                    width: 320.w,
                    color: clr_blue.withOpacity(0.15),
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                          height: 90.h,
                          width: 100.w,
                          color: clr_dark_blue.withOpacity(0.30),
                          child: IconButton(
                            onPressed: () {
                              addNewAddress(context);
                            },
                            icon: Icon(
                              Icons.add,
                              color: clr_n_light,
                              size: 50,
                            ),
                          )),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Divider(
                thickness: 2,
                color: clr_n_light,
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
                        return Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        );
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
                              padding: EdgeInsets.only(
                                top: 5,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        color: clr_blue,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        data['name'],
                                        textAlign: TextAlign.left,
                                        style: textTheme.headline4,
                                      ),
                                      TextButton(
                                          onPressed: () {
                                            editAddress(
                                                context,
                                                data.id,
                                                data['name'],
                                                data['phone'],
                                                data['street_address'],
                                                data['city'],
                                                data['division'],
                                                data['zip_code']);
                                          },
                                          child: Text('Edit'))
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.phone,
                                        color: clr_blue,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        data['phone'],
                                        style: textTheme.headline4,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        child: Icon(
                                          Icons.home,
                                          color: clr_blue,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Expanded(
                                        child: Text(
                                          '${data['street_address']}, ${data['city']} , ${data['division']}, ${data['zip_code']}',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      )
                                    ],
                                  ),
                                  Divider(
                                    thickness: 2,
                                    color: clr_n_light,
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

  addNewAddress(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (_) {
          return Container(
            padding: EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: Column(
                  children: [
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Enter Your Shipping Address',
                            style: textTheme.headline4,
                          ),
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                                clearText();
                              },
                              icon: Icon(
                                Icons.close,
                                color: clr_blue,
                              ))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    CustomTextFiled(
                        hintText: 'Full Name',
                        obscureText: false,
                        controller: _nameController),
                    SizedBox(
                      height: 15,
                    ),
                    CustomTextFiled(
                        hintText: 'Phone',
                        obscureText: false,
                        controller: _phoneController),
                    SizedBox(
                      height: 15,
                    ),
                    CustomTextFiled(
                        hintText: 'Street address',
                        obscureText: false,
                        controller: _streetAddressController),
                    SizedBox(
                      height: 15,
                    ),
                    CustomTextFiled(
                        hintText: 'City',
                        obscureText: false,
                        controller: _cityController),
                    SizedBox(
                      height: 15,
                    ),
                    CustomTextFiled(
                        hintText: 'Division',
                        obscureText: false,
                        controller: _divisonController),
                    SizedBox(
                      height: 15,
                    ),
                    CustomTextFiled(
                        hintText: 'Zip Code',
                        obscureText: false,
                        controller: _zipController),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: 250,
                      child: CustomButtonPage(
                          text: 'Save Address',
                          onPressed: () {
                            CrudFirebase().addNewAddress(
                                context: context,
                                name: _nameController.text,
                                phone: _phoneController.text,
                                street_address: _streetAddressController.text,
                                city: _cityController.text,
                                division: _divisonController.text,
                                zip_code: _zipController.text);

                            Navigator.pop(context);
                          }),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  editAddress(BuildContext context, dynamic data_id, String name, String phone,
      String street_address, String city, String division, String zip_code) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (_) {
          return Container(
            padding: EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: Column(
                  children: [
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Edit Your Shipping Address',
                            style: textTheme.headline4,
                          ),
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.close,
                                color: clr_blue,
                              ))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    CustomTextFiled(
                        hintText: 'Full Name',
                        obscureText: false,
                        controller: _nameController =
                            TextEditingController(text: name)),
                    SizedBox(
                      height: 15,
                    ),
                    CustomTextFiled(
                        hintText: 'Phone',
                        obscureText: false,
                        controller: _phoneController =
                            TextEditingController(text: phone)),
                    SizedBox(
                      height: 15,
                    ),
                    CustomTextFiled(
                        hintText: 'Street address',
                        obscureText: false,
                        controller: _streetAddressController =
                            TextEditingController(text: street_address)),
                    SizedBox(
                      height: 15,
                    ),
                    CustomTextFiled(
                        hintText: 'City',
                        obscureText: false,
                        controller: _cityController =
                            TextEditingController(text: city)),
                    SizedBox(
                      height: 15,
                    ),
                    CustomTextFiled(
                        hintText: 'Division',
                        obscureText: false,
                        controller: _divisonController =
                            TextEditingController(text: division)),
                    SizedBox(
                      height: 15,
                    ),
                    CustomTextFiled(
                        hintText: 'Zip Code',
                        obscureText: false,
                        controller: _zipController =
                            TextEditingController(text: zip_code)),
                    SizedBox(
                      height: 20,
                    ),
                    TextButton(
                        child: Text(
                          'Delete Address',
                          style: TextStyle(color: Colors.red),
                        ),
                        onPressed: () {
                          FirebaseFirestore.instance
                              .collection('users-address')
                              .doc(FirebaseAuth.instance.currentUser!.email)
                              .collection('address')
                              .doc(data_id)
                              .delete();
                          customToast('Remove Successfully!!', context);

                          Navigator.pop(context);
                        }),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: 250,
                      child: CustomButtonPage(
                          text: 'Save Address',
                          onPressed: () {
                            CrudFirebase().addNewAddress(
                                context: context,
                                name: _nameController.text,
                                phone: _phoneController.text,
                                street_address: _streetAddressController.text,
                                city: _cityController.text,
                                division: _divisonController.text,
                                zip_code: _zipController.text);

                            Navigator.pop(context);
                          }),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
