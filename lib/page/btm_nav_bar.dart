import 'package:ecommerce_app/const/const.dart';
import 'package:ecommerce_app/page/cart_page.dart';
import 'package:ecommerce_app/page/category/category_page.dart';
import 'package:ecommerce_app/page/home_page.dart';
import 'package:ecommerce_app/page/user_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class BtmNavBarPage extends StatefulWidget {
  const BtmNavBarPage({super.key});

  @override
  State<BtmNavBarPage> createState() => _BtmNavBarPageState();
}

class _BtmNavBarPageState extends State<BtmNavBarPage> {
  int _selectIndex = 0;
  final List _pages = [HomePage(), CategoryPage(), CartPage(), UserPage()];

  void _selectedPage(int index) {
    setState(() {
      _selectIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: _pages[_selectIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectIndex,
          onTap: _selectedPage,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: clr_blue,
          unselectedItemColor: clr_n_grey,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(
                  _selectIndex == 0 ? IconlyBold.home : IconlyLight.home,
                ),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(
                  _selectIndex == 1
                      ? IconlyBold.category
                      : IconlyLight.category,
                ),
                label: 'Category'),
            BottomNavigationBarItem(
                icon: Icon(
                  _selectIndex == 2 ? IconlyBold.buy : IconlyLight.buy,
                ),
                label: 'Cart'),
            BottomNavigationBarItem(
                icon: Icon(
                  _selectIndex == 3 ? IconlyBold.user2 : IconlyLight.user2,
                ),
                label: 'User'),
          ]),
    ));
  }
}
