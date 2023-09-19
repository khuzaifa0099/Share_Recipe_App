

import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zakwamfyp/screen/Dashboard/home/screen/home_screen.dart';
import 'package:zakwamfyp/screen/Dashboard/profile/screen/profile_screen.dart';
import 'package:zakwamfyp/screen/Dashboard/search/screen/search_screen.dart';
import 'package:zakwamfyp/utils/colors.dart';

import '../screen/Dashboard/post/screen/post_screen.dart';
import '../screen/Dashboard/save/screen/favorite_screen.dart';


class BottomNavigationBarScreen extends StatefulWidget {
  const BottomNavigationBarScreen({Key? key}) : super(key: key);
  @override
  State<BottomNavigationBarScreen> createState() => _BottomNavigationBarScreenState();
}
class _BottomNavigationBarScreenState extends State<BottomNavigationBarScreen> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    SearchScreen(),
    PostScreen(),
    FavoriteScreen(),
    ProfileScreen(),


  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0), ),
        child: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: BottomNavigationBar(
            unselectedIconTheme: IconThemeData(
                color: Colors.grey
            ),
            type: BottomNavigationBarType.fixed,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined,size: 30,),
                label: '',
                // backgroundColor: ConstantColor.primary,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search,size: 30,),
                label: '',
                // backgroundColor: ConstantColor.primary,
              ),
              BottomNavigationBarItem(
                icon: SizedBox.shrink(), // An empty SizedBox
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite,size: 30,),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline,size: 30,),
                label: '',
                // backgroundColor: ConstantColor.primary,
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: AppColor.primary,
            onTap: _onItemTapped,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 60),
        child: FloatingActionButton(
          backgroundColor: AppColor.primary,
          onPressed: () {
            Get.to(()=>PostScreen());
          },
          child: Icon(Icons.add,size: 30,),

        ),
      )
    );
  }

}
