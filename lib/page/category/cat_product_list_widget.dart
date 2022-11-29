import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/const/const.dart';
import 'package:ecommerce_app/page/product_details_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CatProductListWidget extends StatelessWidget {
  CatProductListWidget({super.key});
  static const id = '/ProductPage';

  final _db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final data =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    var category = data['category'];
    var catCollection = data['catCollection'];
    var id = data['id'];

    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
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
                    category,
                    style: textTheme.headline4,
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 2,
            ),
            StreamBuilder<QuerySnapshot>(
              stream: _db
                  .collection('categories')
                  .doc(id)
                  .collection(catCollection)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                        color: clr_blue,
                        borderRadius: BorderRadius.circular(15)),
                    child: Center(
                        child: SpinKitWave(
                      color: clr_white,
                      duration: Duration(seconds: 10),
                      size: 50.0,
                    )),
                  );
                }
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: GridView.builder(
                      itemCount: snapshot.data!.docs.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisExtent: 350,
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      primary: false,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        var data = snapshot.data!.docs;
                        return InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(ProductDetailsPage.id, arguments: {
                              'productName': data[index]['productName'],
                              'productImage': data[index]['productImage'],
                              'productPrice': data[index]['productPrice'],
                              'productInfo': data[index]['productInfo'],
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                border:
                                    Border.all(color: clr_n_light, width: 2)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 5,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Image.network(
                                        data[index]['productImage'],
                                        fit: BoxFit.fitHeight,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Text(data[index]['productName'],
                                        style: TextStyle(
                                            color: clr_dark_blue,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            overflow: TextOverflow.ellipsis)),
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            child: Text(
                                              '\$${data[index]['productPrice']}',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: clr_blue),
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            child: CupertinoButton(
                                              onPressed: () {
                                                addToWishlist(data[index]);
                                                customToast(
                                                    'Added to wishlist successfully!!',
                                                    context);
                                              },
                                              child: Icon(
                                                Icons.favorite_border_rounded,
                                                color: clr_blue,
                                                size: 30,
                                              ),
                                            ),
                                          )
                                        ],
                                      ))
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                );
              },
            )
          ],
        ),
      )),
    );
  }
}
