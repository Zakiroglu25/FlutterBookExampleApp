import 'package:flutter/material.dart';
import 'package:flutter_book_portfolio/screens/BookPage.dart';
import 'package:flutter_book_portfolio/screens/FavoritePage.dart';
import 'package:flutter_book_portfolio/screens/SettingsPage.dart';

class DrawerMenu extends StatefulWidget {
  @override
  _DrawerMenuState createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {

  int currentIndex = 0;
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
    return Drawer(
      child: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              children: <Widget>[
                InkWell(
                  onTap: (){
                  },
                  splashColor: Colors.cyan,
                  child: ListTile(
                    leading: Icon(Icons.add_to_home_screen),
                    title: Text(
                      "Home Page",
                      style: TextStyle(fontSize: 20.0),
                    ),
                    trailing: Icon(Icons.keyboard_arrow_right),
                  ),
                ),
                InkWell(
                  onTap: (){
                    debugPrint("Mail Page");
                  },
                  splashColor: Colors.cyan,
                  child: ListTile(
                    leading: Icon(Icons.mail),
                    title: Text(
                      "Search Page",
                      style: TextStyle(fontSize: 20.0),
                    ),
                    trailing: Icon(Icons.portrait),
                  ),
                ),
                InkWell(
                  onTap: (){
                  },
                  splashColor: Colors.cyan,
                  child: ListTile(
                    leading: Icon(Icons.info),
                    title: Text(
                      "Example Page",
                      style: TextStyle(fontSize: 20.0),
                    ),
                    trailing: Icon(Icons.info),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
