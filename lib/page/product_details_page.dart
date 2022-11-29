import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/const/const.dart';
import 'package:ecommerce_app/page/cart_page.dart';
import 'package:ecommerce_app/widget/customButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:readmore/readmore.dart';

class ProductDetailsPage extends StatefulWidget {
  static const id = '/product-detail-page';

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  @override
  Widget build(BuildContext context) {
    final data =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    var productName = data['productName'];
    var productImage = data['productImage'];
    var productPrice = data['productPrice'];
    var productInfo = data['productInfo'];
    var id = data['id'];

    return SafeArea(
        child: Scaffold(
      bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 57.h,
                width: 270.w,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(5)),
                child: CupertinoButton(
                    color: clr_blue,
                    onPressed: () {
                      addToCart(data);
                      customToast('Added to cart successfully!!', context);
                      Navigator.of(context).pushNamed(CartPage.id);
                    },
                    child: Text(
                      'Add to Cart',
                      style: textTheme.headline6,
                    )),
              ),
              Container(
                height: 57.h,
                width: 70.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5), color: clr_blue),
                child: CupertinoButton(
                  onPressed: () {
                    addToWishlist(data).then((value) => customToast(
                        'Added to wishlist successfully!!', context));
                  },
                  child:
                      Icon(Icons.favorite_outline, size: 40, color: clr_white),
                ),
              ),
            ],
          )),
      backgroundColor: clr_white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 240.h,
                  width: 375.w,
                  decoration: BoxDecoration(
                      color: clr_white,
                      image:
                          DecorationImage(image: NetworkImage(productImage))),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CupertinoButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Icon(
                          Icons.arrow_back,
                          color: clr_n_grey,
                        )),
                    CupertinoButton(
                        onPressed: () {},
                        child: Icon(
                          Icons.shopping_cart_outlined,
                          color: clr_n_grey,
                        ))
                  ],
                )
              ],
            ),
            Divider(
              thickness: 2,
              color: clr_n_light,
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          child: Text(
                            productName,
                            style: textTheme.headline4,
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Text(
                    '\$${productPrice}',
                    style: textTheme.headline1,
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Container(
                    child: ReadMoreText(
                      productInfo,
                      style: textTheme.bodyText1,
                      textAlign: TextAlign.justify,
                      trimLines: 4,
                      colorClickableText: clr_dark_blue,
                      trimMode: TrimMode.Line,
                      trimCollapsedText: 'Show more',
                      trimExpandedText: 'Show less',
                      moreStyle: textTheme.bodyMedium,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
