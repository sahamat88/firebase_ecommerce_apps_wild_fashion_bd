import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/const/const.dart';
import 'package:ecommerce_app/firebase_db/firebase_crud.dart';
import 'package:ecommerce_app/page/home_page.dart';
import 'package:ecommerce_app/widget/customButton.dart';
import 'package:ecommerce_app/widget/customTextfiled.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class UserInfoPage extends StatefulWidget {
  @override
  State<UserInfoPage> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  bool isLoading = false;
  String? _selectGender;
  XFile? _userImage;
  String? image;

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

    File imageFile = File(_userImage!.path);
    FirebaseStorage _storage = FirebaseStorage.instance;
    UploadTask _uploadTask = _storage
        .ref(FirebaseAuth.instance.currentUser!.email)
        .child(_userImage!.name)
        .putFile(imageFile);
    TaskSnapshot snapshot = await _uploadTask;
    image = await snapshot.ref.getDownloadURL();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 30.h,
                ),
                Text(
                  "Thanks for signing Up!",
                  style: textTheme.headline4,
                ),
                SizedBox(
                  height: 8.h,
                ),
                Text(
                  "Submit Your Information",
                  style: textTheme.bodyText1,
                ),
                SizedBox(
                  height: 8.h,
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
                  height: 50.h,
                ),
                CustomTextFiled(
                    hintText: "Full Name",
                    controller: _nameController,
                    obscureText: false),
                SizedBox(
                  height: 10.h,
                ),
                CustomTextFiled(
                    hintText: "Phone",
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
                    hintText: "Date Of Birth",
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
                            "Gender",
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
                    hintText: "Age",
                    controller: _ageController,
                    obscureText: false,
                    keyboardType: TextInputType.number),
                SizedBox(
                  height: 10.h,
                ),
                CustomTextFiled(
                    hintText: "Address",
                    controller: _addressController,
                    obscureText: false,
                    keyboardType: TextInputType.text),
                SizedBox(
                  height: 15.h,
                ),
                CustomButtonPage(
                  text: 'Submit',
                  onPressed: () {
                    CrudFirebase().addUser(
                        context: context,
                        image: image.toString(),
                        name: _nameController.text,
                        selectGender: _selectGender.toString(),
                        phone: _phoneController.text,
                        dateBirth: _dobController.text,
                        age: _ageController.text,
                        address: _addressController.text);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
