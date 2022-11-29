import 'package:ecommerce_app/firebase_authentication/auth_service.dart';
import 'package:ecommerce_app/firebase_authentication/sign_up.dart';
import 'package:ecommerce_app/const/const.dart';

import 'package:ecommerce_app/widget/customButton.dart';
import 'package:ecommerce_app/widget/customTextfiled.dart';

import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class SignInPage extends StatefulWidget {
  SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  
  bool isLoading = false;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  height: 70.h,
                  width: 70.h,
                  decoration: BoxDecoration(
                      color: clr_blue, borderRadius: BorderRadius.circular(20)),
                  child: Image.asset(
                    "assets/icons/logo.png",
                    color: clr_white,
                    fit: BoxFit.cover,
                  )),
              SizedBox(
                height: 30.h,
              ),
              Text(
                "Welcome To Wild Hue Fashion",
                style: textTheme.headline4,
              ),
              SizedBox(
                height: 8.h,
              ),
              Text(
                "Sign in to continue",
                style: textTheme.bodyText1,
              ),
              SizedBox(
                height: 50.h,
              ),
              CustomTextFiled(
                  icon: IconlyLight.message,
                  hintText: 'Email',
                  controller: _emailController,
                  obscureText: false),
              SizedBox(
                height: 10.h,
              ),
              CustomTextFiled(
                  icon: IconlyLight.lock,
                  hintText: 'Password',
                  controller: _passwordController,
                  obscureText: true),
              SizedBox(
                height: 15.h,
              ),
              isLoading
                  ? CircularProgressIndicator()
                  : CustomButtonPage(
                      text: "Sign in",
                      onPressed: () {
                        AuthService().signIn(_emailController.text,
                            _passwordController.text, context);
                      }),
              SizedBox(
                height: 15.h,
              ),
              Text(
                "Or",
                style: textTheme.headline5,
              ),
              SizedBox(
                height: 15.h,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have a account"),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (conntext) => SignUpPage()));
                        },
                        child: Text(
                          "Sign Up!",
                          style: textTheme.button,
                        ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
