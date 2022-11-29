import 'package:ecommerce_app/firebase_authentication/auth_service.dart';
import 'package:ecommerce_app/firebase_authentication/sign_in.dart';
import 'package:ecommerce_app/const/const.dart';
import 'package:ecommerce_app/page/home_page.dart';
import 'package:ecommerce_app/widget/customButton.dart';
import 'package:ecommerce_app/widget/customTextfiled.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool isLoading = false;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _cpasswordController = TextEditingController();
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
                "Join  To Bazar-Shodai",
                style: textTheme.headline4,
              ),
              SizedBox(
                height: 8.h,
              ),
              Text(
                "Create a new account",
                style: textTheme.bodyText1,
              ),
              SizedBox(
                height: 50.h,
              ),
              CustomTextFiled(
                hintText: 'Email',
                controller: _emailController,
                obscureText: false,
                icon: IconlyLight.message,
              ),
              SizedBox(
                height: 10.h,
              ),
              CustomTextFiled(
                hintText: 'Password',
                controller: _passwordController,
                obscureText: true,
                icon: IconlyLight.lock,
              ),
              SizedBox(
                height: 10.h,
              ),
              CustomTextFiled(
                hintText: 'Confirm Password',
                controller: _cpasswordController,
                obscureText: true,
                icon: IconlyLight.lock,
              ),
              SizedBox(
                height: 15.h,
              ),
              isLoading
                  ? CircularProgressIndicator()
                  : CustomButtonPage(
                      text: "Sign Up",
                      onPressed: () async {
                        AuthService().signUp(_emailController.text,
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
                    Text("Already a account?"),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignInPage()));
                        },
                        child: Text(
                          "Sign In",
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
