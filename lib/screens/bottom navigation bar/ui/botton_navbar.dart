import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:wallpaperapp/screens/category%20screen/ui/categories_screen.dart';
import 'package:wallpaperapp/screens/home%20screen/ui/home_screen.dart';
import 'package:wallpaperapp/screens/search%20screen/ui/search_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int selectedTabIndex = 0;

  late HomeScreen homeScreen;
  late SearchScreen searchScreen;
  late CategoriesScreen categoriesScreen;
  late List<Widget> pages;

  @override
  void initState() {
    homeScreen = const HomeScreen();
    searchScreen = const SearchScreen();
    categoriesScreen = const CategoriesScreen();
    pages = [homeScreen, searchScreen, categoriesScreen];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: pages[selectedTabIndex],
      bottomNavigationBar: CurvedNavigationBar(
        onTap: (value) {
          setState(() {
            selectedTabIndex = value;
          });
        },
        height: height * 0.074,
        animationDuration: const Duration(milliseconds: 500),
        buttonBackgroundColor: Colors.black,
        backgroundColor: Colors.white,
        index: 0,
        color: const Color.fromARGB(255, 61, 60, 60),
        items: [
          Icon(
            Icons.home,
            size: width * 0.072,
            color: Colors.white,
          ),
          Icon(
            Icons.search,
            size: width * 0.072,
            color: Colors.white,
          ),
          Icon(
            Icons.category,
            size: width * 0.072,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
