import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'login_page.dart';
import './home.dart';
import './profile.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
//   SharedPreferences sharedPreferences;

//   @override
//   void initState() {
//     super.initState();
//     checkLoginStatus();
//   }

//   int pageIndex = 1;

//   final Home _home = Home();
//   final Profile _profile = Profile();

//   Widget _showPage = Profile();

//   Widget _pageChoser(int page) {
//     switch (page) {
//       case 0:
//         return _home;
//         break;
//       case 1:
//         return _profile;
//         break;
//       default:
//         return Container(
//           child: Center(
//             child: Text(
//               'No page',
//               style: TextStyle(fontSize: 30),
//             ),
//           ),
//         );
//     }
//   }

//   GlobalKey _bottomNavigationKey = GlobalKey();

//   checkLoginStatus() async {
//     sharedPreferences = await SharedPreferences.getInstance();
//     if (sharedPreferences.getString("token") == null) {
//       Navigator.of(context).pushAndRemoveUntil(
//           MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
//           (Route<dynamic> route) => false);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//      Size size = MediaQuery.of(context).size;
//     final screenWidth = size.width;
//     final screenHeight = size.height;
//     return Scaffold(
//         bottomNavigationBar: CurvedNavigationBar(
//           index: pageIndex,
//           backgroundColor: Colors.transparent,
//           key: _bottomNavigationKey,
//           items: <Widget>[
//             Icon(Icons.home, size: 30),
//             Icon(Icons.person, size: 30),
//           ],
//           onTap: (index) {
//             setState(() {
//               _showPage = _pageChoser(index);
//             });
//           },
//         ),
//         body: Container(
//           decoration: BoxDecoration(
//             color: Theme.of(context).primaryColor,
//           ),
//           child: Center(
//             child: _showPage
//           ),
//         ));
//   }
SharedPreferences sharedPreferences;

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if(sharedPreferences.getString("token") == null) {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => LoginPage()), (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Code Land", style: TextStyle(color: Colors.white)),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              sharedPreferences.clear();
              sharedPreferences.commit();
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => LoginPage()), (Route<dynamic> route) => false);
            },
            child: Text("Log Out", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: Center(child: Text("Main Page")),
      drawer: Drawer(),
    );
  }
}
