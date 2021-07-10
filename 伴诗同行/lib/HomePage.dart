import 'package:dailypoetry/dailyPoetry/DailyPoetry.dart';
import 'package:dailypoetry/searchPoetry/searchPoetry.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


class HomePage extends StatefulWidget {
  static const String routeName = "/home";
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<BottomNavigationBarItem> bottomNavItems = [
    new BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.house),
        label: "每日一首"),
    new BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.search),
        label: "搜索"),
  ];

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    if (index != _selectedIndex) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  final List<Widget> pages = [DailyPoetry(), SearchPoetry()];

  @override
  void initState() {
    super.initState();
    _selectedIndex = 0;
  }

  onPushTap(BuildContext context) {
    Navigator.of(context).pushNamed("/home");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFF292a3e),
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.red,
        items: bottomNavItems,
        currentIndex: _selectedIndex,
        onTap: (index) {
          _onItemTapped(index);
        },
      ),
      body: pages[_selectedIndex],
    );
  }
}
