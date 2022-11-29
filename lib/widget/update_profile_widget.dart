import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/const/const.dart';
import 'package:ecommerce_app/firebase_db/firebase_crud.dart';
import 'package:ecommerce_app/page/home_page.dart';
import 'package:ecommerce_app/widget/customButton.dart';
import 'package:ecommerce_app/widget/customTextfiled.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:io';

class UpdateProfileWidget extends StatefulWidget {
  @override
  State<UpdateProfileWidget> createState() => _UpdateProfileWidgetState();
}

class _UpdateProfileWidgetState extends State<UpdateProfileWidget> {
  final Stream<DocumentSnapshot> _userStream = FirebaseFirestore.instance
      .collection("users")
      .doc(FirebaseAuth.instance.currentUser!.email)
      .snapshots();
  XFile? _userImage;
  bool isLoading = false;
  String? _selectGender;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _dobController = TextEditingController();
  TextEditingController _genderController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  List<String> genderList = ["Male", "Female", "Other"];

  Future<void> _selectDateFromPicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(DateTime.now().year - 20),
      firstDate: DateTime(DateTime.now().year - 30),
      lastDate: DateTime(DateTime.now().year),
    );
    if (picked != null)
      setState(() {
        _dobController.text = "${picked.day}/ ${picked.month}/ ${picked.year}";
      });
  }

  Future userImagePicker() async {
    ImagePicker _picker = ImagePicker();
    _userImage = await _picker.pickImage(source: ImageSource.camera);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: _userStream,
        builder: ((BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Text("Loading");
          } else if (snapshot.hasError) {
            return Text('Something went wrong');
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          var data = snapshot.data;
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Update your profile",
                    style: textTheme.headline4,
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    alignment: Alignment.center,
                    child: _userImage == null
                        ? InkWell(
                            onTap: () {
                              userImagePicker();
                            },
                            child: CircleAvatar(
                              backgroundColor: clr_blue,
                              child: Icon(
                                Icons.add_photo_alternate_rounded,
                                size: 50,
                                color: clr_white,
                              ),
                              radius: 50,
                            ))
                        : CircleAvatar(
                            backgroundImage: FileImage(File(_userImage!.path)),
                            backgroundColor: clr_blue,
                            radius: 50,
                          ),
                  ),
                  Divider(
                    thickness: 2,
                    color: clr_n_light,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  CustomTextFiled(
                      hintText: data['name'],
                      controller: _nameController,
                      obscureText: false),
                  SizedBox(
                    height: 10.h,
                  ),
                  CustomTextFiled(
                      hintText: data['phone'],
                      controller: _phoneController,
                      obscureText: false,
                      keyboardType: TextInputType.number),
                  SizedBox(
                    height: 10.h,
                  ),
                  TextField(
                    onTap: () {
                      _selectDateFromPicker(context);
                    },
                    controller: _dobController,
                    style: textTheme.bodyText2,
                    decoration: InputDecoration(
                      hintText: data['dob'],
                      hintStyle: textTheme.bodyText1,
                      prefixIconColor: clr_n_grey,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(color: clr_blue)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(color: clr_blue)),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  FormField<String>(
                    builder: (FormFieldState<String> state) {
                      return InputDecorator(
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(color: clr_blue)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(color: clr_blue)),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            hint: Text(
                              data['gender'],
                              style: textTheme.bodyText1,
                            ),
                            value: _selectGender,
                            isDense: true,
                            onChanged: (value) {
                              setState(() {
                                _selectGender = value;
                              });
                            },
                            items: genderList.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: textTheme.bodyText2,
                                ),
                                onTap: () {
                                  _selectGender = value;
                                },
                              );
                            }).toList(),
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  CustomTextFiled(
                      hintText: data['age'],
                      controller: _ageController,
                      obscureText: false,
                      keyboardType: TextInputType.number),
                  SizedBox(
                    height: 10.h,
                  ),
                  CustomButtonPage(
                    text: 'Update',
                    onPressed: () {
                      CrudFirebase().updateUser(
                          context: context,
                          name: _nameController.text,
                          selectGender: _selectGender.toString(),
                          phone: _phoneController.text,
                          dateBirth: _dobController.text,
                          age: _ageController.text,
                          address: _addressController.text);
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
            ),
          );
        }));
  }
}
