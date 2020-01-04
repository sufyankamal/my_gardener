import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'tab_screen.dart';


import 'tab_screen3.dart';
import 'tab_screen4.dart';
import 'user.dart';


class MainScreen extends StatefulWidget {
  final User user;

  const MainScreen({Key key, this.user}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Widget> tabs;

  int currentTabIndex = 0;

  @override
  void initState() {
    super.initState();
    tabs = [
      TabScreen(user: widget.user),
       
      TabScreen3(user: widget.user),
      TabScreen4(user: widget.user),
    ];
  }

  String $pagetitle = "My Gardener";

  onTapped(int index) {
    setState(() {
      currentTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Color.fromRGBO(34,139,34, 1)));
    return Scaffold(
      body: tabs[currentTabIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTapped,
        currentIndex: currentTabIndex,

        type: BottomNavigationBarType.fixed,

        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text("Gardener"),
          ),
       
        
    
          BottomNavigationBarItem(
            icon: Icon(Icons.event, ),
            title: Text("Booked"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, ),
            title: Text("My Profile"),
          )
        ],
      ),
    );
  }
}
