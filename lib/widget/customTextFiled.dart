import 'package:ecommerce_app/const/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CustomTextFiled extends StatelessWidget {
  CustomTextFiled(
      {super.key,
      required this.hintText,
      required this.obscureText,
      required this.controller,
      this.keyboardType,
      this.icon});
  TextEditingController controller;
  String hintText;
  IconData? icon;
  bool obscureText;
  TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: keyboardType,
      controller: controller,
      obscureText: obscureText,
      style: textTheme.bodyText2,
      decoration: InputDecoration(
        prefixIcon: Icon(
          icon,
          color: clr_n_grey,
        ),
        hintText: hintText,
        hintStyle: textTheme.bodyText1,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: clr_n_light)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: clr_blue)),
      ),
    );
  }
}
