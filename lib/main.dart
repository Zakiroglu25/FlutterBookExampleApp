import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_book_portfolio/screens/FavoritePage.dart';
import 'package:flutter_book_portfolio/screens/BookPage.dart';
import 'package:flutter_book_portfolio/screens/SettingsPage.dart';
import 'package:flutter_svg/svg.dart';

import 'helper/drawer_page.dart';

void main() {
  runApp(MaterialApp(
    title: 'Page Routes',
    debugShowCheckedModeBanner: false,
    home: MyHomePage(),
  ));
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentIndex = 0;
  void changePage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  List<Widget> allPages;
  BookPage bookPage;
  FavPage favPage;
  SettingsPage settingsPage;

  @override
  void initState() {
    super.initState();
    bookPage = BookPage();
    favPage = FavPage();
    settingsPage = SettingsPage();
    allPages = [bookPage, favPage, settingsPage];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerMenu(),
      appBar: AppBar(
        backgroundColor: Colors.black45,
        centerTitle: true,
        title: Text("Page Routes Example",style: TextStyle(color: Colors.white),),
      ),
      body: allPages[currentIndex],
      bottomNavigationBar:  BubbleBottomBar(
        opacity: 0,
        currentIndex: currentIndex,
        onTap: changePage,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        elevation: 8,
        items: <BubbleBottomBarItem>[
          BubbleBottomBarItem(
              backgroundColor: Colors.black,
              icon: SvgPicture.asset(
                'asset/home.svg',
                width: 21,
                color: Colors.black54,
                height: 21,
              ),
              activeIcon: SvgPicture.asset(
                'asset/home.svg',
                width: 21,
                color: Colors.black,
                height: 21,
              ),
              title: Text("Home")),
          BubbleBottomBarItem(
              backgroundColor: Colors.black,
              icon: SvgPicture.asset(
                'asset/search.svg',
                width: 21,
                color: Colors.black54,
                height: 21,
              ),
              activeIcon: SvgPicture.asset(
                'asset/search.svg',
                width: 21,
                color: Colors.black,
                height: 21,
              ),
              title: Text("Search")),
          BubbleBottomBarItem(
              backgroundColor: Colors.black,
              icon: SvgPicture.asset(
                'asset/bookmark.svg',
                width: 21,
                color: Colors.black54,
                height: 21,
              ),
              activeIcon: SvgPicture.asset(
                'asset/bookmark.svg',
                width: 21,
                color: Colors.black,
                height: 21,
              ),
              title: Text("Example")),
        ],
      ),
    );
  }
}