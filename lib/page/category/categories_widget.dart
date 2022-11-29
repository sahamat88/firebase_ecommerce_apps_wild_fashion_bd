import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/const/const.dart';
import 'package:ecommerce_app/page/category/cat_product_list_widget.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CategoriesWidget extends StatelessWidget {
  CategoriesWidget({super.key, required this.scrollDirection});

  Axis scrollDirection;
  final Stream<QuerySnapshot> _categories = FirebaseFirestore.instance
      .collection('categories')
      .orderBy('catIndex', descending: false)
      .snapshots();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _categories,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return ListView.separated(
          scrollDirection: scrollDirection,
          itemCount: snapshot.data!.docs.length,
          separatorBuilder: (_, index) => SizedBox(
            width: 12,
          ),
          itemBuilder: (context, index) {
            var data = snapshot.data!.docs;
            return InkWell(
              onTap: () {
                Navigator.of(context)
                    .pushNamed(CatProductListWidget.id, arguments: {
                  'category': data[index]['catName'],
                  'catCollection': data[index]['catName'],
                  'id': data[index].id
                });
              },
              child: Container(
                width: 100.w,
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 40.sp,
                      backgroundColor: clr_n_light,
                      child: CircleAvatar(
                        backgroundColor: clr_white,
                        child: SvgPicture.network(
                          data[index]['catImage'],
                          color: clr_blue,
                          width: 38.w,
                        ),
                        radius: 38.sp,
                      ),
                    ),
                    Text(
                      data[index]['catName'],
                      style: textTheme.bodyText1,
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
