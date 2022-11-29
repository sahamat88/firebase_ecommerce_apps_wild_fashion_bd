import 'package:ecommerce_app/const/const.dart';
import 'package:ecommerce_app/firebase_authentication/sign_in.dart';
import 'package:ecommerce_app/page/address_page.dart';
import 'package:ecommerce_app/page/address_page.dart';
import 'package:ecommerce_app/page/profile_page.dart';
import 'package:ecommerce_app/page/wishlist.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPage extends StatelessWidget {
  UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(bottom: 5, left: 10, top: 5),
                height: 40.h,
                alignment: Alignment.bottomLeft,
                width: double.infinity,
                child: Text(
                  'Account',
                  style: textTheme.headline4,
                ),
              ),
              Divider(
                thickness: 2,
              ),
              _listTile(
                  title: 'Profile',
                  icon: IconlyLight.profile,
                  onpressd: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => ProfilePage()));
                  }),
              _listTile(
                  title: 'Address',
                  icon: IconlyLight.activity,
                  onpressd: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => AddressPage()));
                  }),
              _listTile(title: 'Order', icon: IconlyLight.bag, onpressd: () {}),
              _listTile(
                  title: 'Wishlist',
                  icon: IconlyLight.heart,
                  onpressd: () {
                    Navigator.of(context).pushNamed(WishListPage.id);
                  }),
              _listTile(
                  title: 'Payment', icon: IconlyLight.wallet, onpressd: () {}),
              _listTile(
                  title: 'Sign Out',
                  icon: IconlyLight.logout,
                  onpressd: () async {
                    SharedPreferences sharedPreferences =
                        await SharedPreferences.getInstance();
                    sharedPreferences.remove('uid');
                    await FirebaseAuth.instance.signOut();
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => SignInPage()));
                  })
            ],
          ),
        ),
      ),
    ));
  }

  _listTile(
      {required String title,
      String? subtitle,
      required IconData icon,
      required Function onpressd}) {
    return ListTile(
      leading: Icon(
        icon,
        color: clr_blue,
      ),
      title: Text(
        title,
        style: textTheme.headline4,
      ),
      subtitle: Text(
        subtitle == null ? "" : subtitle,
        style: textTheme.subtitle1,
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
