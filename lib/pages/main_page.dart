import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:sum_parking/providers/parking_spaces.dart';

import 'login_page.dart';
import './home.dart';
import './profile.dart';
import 'parking_information.dart';
import 'profile.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  SharedPreferences sharedPreferences;

    var _isInit = true;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // checkLoginStatus();
  }

  // checkLoginStatus() async {
  //   sharedPreferences = await SharedPreferences.getInstance();
  //   if (sharedPreferences.getString("token") == null) {
  //     Navigator.of(context).pushAndRemoveUntil(
  //         MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
  //         (Route<dynamic> route) => false);
  //   }
  // }
  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      Provider.of<ParkingSpaces>(context).fetchParkingSpaces().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }
  int pageIndex = 1;

  final Home _home = Home();
  final Profile _profile = Profile();

  Widget _showPage = Profile();

  Widget _pageChoser(int page) {
    switch (page) {
      case 0:
        return _home;
        break;
      case 1:
        return _profile;
        break;
      default:
        return Container(
          child: Center(
            child: Text(
              'No page',
              style: TextStyle(fontSize: 30),
            ),
          ),
        );
    }
  }

  GlobalKey _bottomNavigationKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final screenWidth = size.width;
    final screenHeight = size.height;

    return Scaffold(

      bottomNavigationBar: CurvedNavigationBar(
        index: pageIndex,
        backgroundColor: Colors.transparent,
        color: Colors.blue[800],
        key: _bottomNavigationKey,
        height: 60.0,
        items: <Widget>[
          Icon(Icons.home, size: 30, color: Colors.white,),
          Icon(Icons.person, size: 30, color: Colors.white,),
        ],
        onTap: (index) {
          setState(() {
            _showPage = _pageChoser(index);
          });
        },
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
        ),
        child: Center(child: _showPage),
      ),
    );
  }
}
