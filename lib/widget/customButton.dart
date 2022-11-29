import 'package:ecommerce_app/const/const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButtonPage extends StatelessWidget {
  CustomButtonPage({super.key, required this.text, required this.onPressed});

  String text;
  Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 57.h,
      width: 350.w,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
      child: CupertinoButton(
          color: clr_blue,
          onPressed: () {
            onPressed();
          },
          child: Text(
            text,
            style: textTheme.headline6,
          )),
    );
  }
}
