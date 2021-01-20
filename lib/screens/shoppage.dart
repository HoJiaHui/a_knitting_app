import 'package:a_knitting_app/course/mainclass.dart';
import 'package:a_knitting_app/profile/ProfilePage.dart';
import 'package:a_knitting_app/screens/main.dart';
import 'package:flutter/material.dart';
import 'package:a_knitting_app/screens/communityscreen.dart';


/// This Widget is the main application widget.
class ShopPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyNavigationBar (),
    );
  }
}
class MyNavigationBar extends StatefulWidget {
  MyNavigationBar ({Key key}) : super(key: key);
  @override
  _MyNavigationBarState createState() => _MyNavigationBarState();
}
class _MyNavigationBarState extends State<MyNavigationBar > {
  int _selectedIndex = 0;
  final List<Widget> _options = <Widget>[
    MainScreen(),
    MainClassScreen(),
    ProfileScreen(),
    CommunityScreen(),

  ];
  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Knitting Stuff'),
          backgroundColor: Colors.teal
      ),
      body: Center(
        child: _options.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.add_business),
                label: 'Home',
                backgroundColor: Colors.teal
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.chrome_reader_mode),
                label: 'Study',
                backgroundColor: Colors.yellow
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle),
                label: 'Profile',
                backgroundColor: Colors.cyan
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.message),
              label: 'Chat',
              backgroundColor: Colors.lightBlue,
            ),
          ],
          type: BottomNavigationBarType.shifting,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          iconSize: 40,
          onTap: _onItemTap,
          elevation: 5
      ),
    );
  }
}