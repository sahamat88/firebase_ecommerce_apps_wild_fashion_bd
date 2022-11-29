import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:ecommerce_app/const/const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CarouselImages extends StatefulWidget {
  const CarouselImages({super.key});

  @override
  State<CarouselImages> createState() => _CarouselImagesState();
}

class _CarouselImagesState extends State<CarouselImages> {
  List<String> _carouselImages = [];
  var _dotPosition = 0;
  List _products = [];
  var _firestoreInstance = FirebaseFirestore.instance;

  fetchCarouselImages() async {
    QuerySnapshot qn =
        await _firestoreInstance.collection("carousel-slider").get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        _carouselImages.add(
          qn.docs[i]["image-path"],
        );
        print(qn.docs[i]["image-path"]);
      }
    });

    return qn.docs;
  }

  @override
  void initState() {
    fetchCarouselImages();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
            items: _carouselImages
                .map((item) => Padding(
                      padding: const EdgeInsets.only(left: 3, right: 3),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(item),
                                  fit: BoxFit.fitWidth)),
                        ),
                      ),
                    ))
                .toList(),
            options: CarouselOptions(
                autoPlay: false,
                enlargeCenterPage: true,
                height: 200,
                viewportFraction: 1,
                enlargeStrategy: CenterPageEnlargeStrategy.height,
                onPageChanged: (val, carouselPageChangedReason) {
                  setState(() {
                    _dotPosition = val;
                  });
                })),
        SizedBox(
          height: 10,
        ),
        DotsIndicator(
          dotsCount: _carouselImages.length == 0 ? 1 : _carouselImages.length,
          position: _dotPosition.toDouble(),
          decorator: DotsDecorator(
            activeColor: clr_blue,
            color: clr_n_light,
            spacing: EdgeInsets.all(2),
            activeSize: Size(10, 10),
            size: Size(8, 8),
          ),
        ),
      ],
    );
  }
}
