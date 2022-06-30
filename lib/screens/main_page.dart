import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobilehairdresser_app/constant.dart';
import 'package:mobilehairdresser_app/screens/home_page.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:mobilehairdresser_app/screens/user_adress_edit_page.dart';
import 'package:mobilehairdresser_app/screens/user_adress_page.dart';

import 'appointments_page.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _pageIndex = 0;
  PageController pageController = PageController(initialPage: 0);


  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      body: PageView(
        controller: pageController,
        onPageChanged: (index){
          _pageIndex = index;
        },
        children: [
          const HomePage(),
          UserAdressPage(),
          Appointments(),
          UserAdressEdit(),
        ],
      ),
      bottomNavigationBar:  GNav(
        
        backgroundColor: Colors.black87,
        color: Colors.white,
        activeColor: Colors.white,
        tabBackgroundColor: Colors.purple.shade700,
        tabBorderRadius: 30,
        gap: 8,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        selectedIndex: _pageIndex,
        onTabChange: (index) {
            pageController.animateToPage(index, duration: Duration(milliseconds: 1500), curve: Curves.ease);
            
        },
        tabs:  const [
          GButton(
            icon: Icons.home,
            text: "Home",
          ),
          GButton(
            icon: Icons.add_box,
            text: 'Oluştur',
          ),
          GButton(
            icon: Icons.library_books,
            text: 'Randevular',
            
          ),
          GButton(
            icon: Icons.location_city,
            text: 'Adres',
          ),
          
        ],
      ),
    );
  }
}