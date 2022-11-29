import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/const/const.dart';
import 'package:ecommerce_app/page/category/cat_product_list_widget.dart';
import 'package:ecommerce_app/page/category/categories_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CategoryPage extends StatelessWidget {
  CategoryPage({super.key});

  static const id = '/category-page';

  final Stream<QuerySnapshot> _categories = FirebaseFirestore.instance
      .collection('categories')
      .orderBy('catIndex', descending: false)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
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
                    'Category',
                    style: textTheme.headline4,
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 2,
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _categories,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: SpinKitRotatingCircle(
                        color: Colors.white,
                        size: 50.0,
                      ),
                    );
                  }

                  return ListView.separated(
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data!.docs.length,
                    separatorBuilder: (_, index) => SizedBox(
                      height: 12,
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
                        child: Row(
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
                            SizedBox(
                              width: 10.w,
                            ),
                            Container(
                              alignment: Alignment.center,
                              child: Text(
                                data[index]['catName'],
                                style: textTheme.bodyText1,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            SizedBox(
              height: 10.w,
            ),
          ],
        ),
      ),
    ));
  }

  _listTile(
      {required String title, String? subtitle, required Function onpressd}) {
    return ListTile(
      title: Text(
        title,
        style: textTheme.headline4,
      ),
      trailing: Icon(
        IconlyLight.arrowRight2,
        color: clr_n_grey,
      ),
      onTap: () {
        onpressd();
      },
    );
  }
}
