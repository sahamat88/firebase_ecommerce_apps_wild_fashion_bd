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

class HomeScreenProductWidget extends StatelessWidget {
  HomeScreenProductWidget({
    super.key,
    required this.stream,
  });

  dynamic stream;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: stream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            height: 200,
            width: 150,
            child: Center(
                child: SpinKitWave(
              color: clr_white,
              size: 50.0,
            )),
          );
        }
        return Container(
          height: 250.h,
          child: GridView.builder(
              itemCount: snapshot.data!.docs.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              primary: false,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
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
                    height: 700,
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: clr_n_light, width: 3)),
                    child: Column(
                      children: [
                        Expanded(
                          flex: 2,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Container(
                              width: 400,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                image: DecorationImage(
                                    image: NetworkImage(
                                        data[index]['productImage'])),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Expanded(
                            flex: 1,
                            child: Container(
                              width: 250,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(15),
                                    bottomRight: Radius.circular(15)),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data[index]['productName'],
                                    style: TextStyle(
                                        color: clr_dark_blue,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18,
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          child: Text(
                                              '\$${data[index]['productPrice']}',
                                              style: TextStyle(
                                                color: clr_blue,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                              )),
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
                                    ),
                                  )
                                ],
                              ),
                            ))
                      ],
                    ),
                  ),
                );
              }),
        );
      },
    );
  }
}
