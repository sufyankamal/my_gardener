import 'package:flutter/material.dart';


class MainScreen extends StatefulWidget {
  final String email,radius,name,credit;

  const MainScreen({Key key,this.email,this.radius,this.name,this.credit}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Widget> tabs;

  int currentTabIndex = 0;

  @override
  void initState() {

  }

  String $pagetitle = "My Gardener";

  onTapped(int index) {
    setState(() {
      currentTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    //SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      body: tabs[currentTabIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTapped,
        currentIndex: currentTabIndex,
        //backgroundColor: Colors.blueGrey,
        type: BottomNavigationBarType.fixed ,

        items: [
          BottomNavigationBarItem(

          ),
          BottomNavigationBarItem(

          ),
          BottomNavigationBarItem(

          ),
          BottomNavigationBarItem(

          )
        ],
      ),
    );
  }


}