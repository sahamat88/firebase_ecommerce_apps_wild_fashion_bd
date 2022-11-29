import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/const/const.dart';
import 'package:ecommerce_app/firebase_authentication/auth_service.dart';
import 'package:ecommerce_app/widget/customButton.dart';
import 'package:ecommerce_app/widget/update_profile_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _currentUserEmail = FirebaseAuth.instance.currentUser!.email;

  XFile? _userImage;

  Future userImagePicker() async {
    ImagePicker _picker = ImagePicker();
    _userImage = await _picker.pickImage(source: ImageSource.camera);

    setState(() {});
  }

  updateProfile() {
    return showModalBottomSheet(
        backgroundColor: clr_n_light,
        isDismissible: true,
        isScrollControlled: true,
        context: context,
        builder: (context) => Container(
              height: 500.h,
              width: 300.w,
              decoration: BoxDecoration(
                  color: clr_white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: clr_n_light, width: 2)),
              child: UpdateProfileWidget(),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                            'Profile',
                            style: textTheme.headline4,
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      thickness: 2,
                    ),
                    StreamBuilder<DocumentSnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection("users")
                            .doc(_currentUserEmail)
                            .snapshots(),
                        builder: (context, AsyncSnapshot snapshot) {
                          if (!snapshot.hasData) {
                            return Text("Loading");
                          } else if (snapshot.hasError) {
                            return Text('Something went wrong');
                          } else if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          }
                          var data = snapshot.data;
                          return Column(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 20),
                                alignment: Alignment.center,
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(data['image']),
                                  backgroundColor: clr_blue,
                                  radius: 50,
                                ),
                              ),
                              porfileList(
                                'Name',
                                data['name'],
                              ),
                              Divider(
                                thickness: 2,
                              ),
                              porfileList(
                                'Phone',
                                data['phone'],
                              ),
                              Divider(
                                thickness: 2,
                              ),
                              porfileList(
                                'Date of Birth',
                                data['dob'],
                              ),
                              Divider(
                                thickness: 2,
                              ),
                              porfileList(
                                'Age',
                                data['age'],
                              ),
                              Divider(
                                thickness: 2,
                              ),
                              porfileList(
                                'Gender',
                                data['gender'],
                              ),
                            ],
                          );
                        }),
                  ],
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                updateProfile();
              },
              child: Icon(Icons.edit),
            )));
  }

  porfileList(String title, String subtitle) {
    return ListTile(
      title: Text(
        title,
        style: textTheme.headline4,
      ),
      subtitle: Text(
        subtitle,
        style: textTheme.bodyText1,
      ),
    );
  }
}
