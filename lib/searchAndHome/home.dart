import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:osint/config/palette.dart';
import 'package:osint/hunter/hunters.dart';
import 'package:osint/hunter/inputHunter.dart';
import 'package:osint/ip-locator/ipAddress.dart';
import 'package:osint/ip-locator/ips.dart';
import 'package:osint/model/loading.dart';
import 'package:osint/model/navDrawer.dart';
import 'package:http/http.dart' as http;
import 'package:osint/profile-generation/inputDetails.dart';
import 'package:osint/root.dart';
import 'package:osint/services/authService.dart';
import 'dart:convert' as convert;

import 'package:osint/services/sharedPreferences.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool loading = false;
  String _name;
  String country, city, serviceProviderName;
  String ip;
  int _page = 1;
  GlobalKey _bottomNavigationKey = GlobalKey();
  void fun() async {
    String name = await SharedFunctions.getUserName();
    setState(() {
      _name = name;
      loading = true;
    });
    print(_name);
  }

  @override
  void initState() {
    super.initState();
    fun();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: _page,
        color: Palette.lightBlue,
        backgroundColor: Colors.white,
        buttonBackgroundColor: Palette.orange,
        onTap: (value) {
          print(_page);
          setState(() {
            _page = value;
          });
        },
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 400),
        items: [
          Icon(
            Icons.pin_drop_outlined,
            color: Palette.darkBlue,
          ),
          Icon(
            Icons.home_outlined,
            color: Palette.darkBlue,
          ),
          Icon(
            Icons.verified_user_outlined,
            color: Palette.darkBlue,
          )
        ],
      ),
      body: _page == 0
          ? IPs()
          : _page == 1
              ? HomeMain()
              : Hunters(),
    );
  }
}

class HomeMain extends StatefulWidget {
  @override
  _HomeMainState createState() => _HomeMainState();
}

class _HomeMainState extends State<HomeMain> {
  String _name;
  void fun() async {
    String name = await SharedFunctions.getUserName();
    setState(() {
      _name = name;
    });
    print(_name);
  }

  @override
  void initState() {
    super.initState();
    fun();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: Text(
          'Home',
          style: TextStyle(color: Palette.darkBlue),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Welcome back $_name!',
              ),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                  child: Text('Generate Profile'),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => InputHunter()));
                  }),
              SizedBox(height: 50),
              ElevatedButton(
                  child: Text('Locate IP'),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => IPAddress()));
                  }),
              SizedBox(height: 50),
              ElevatedButton(
                  child: Text('Logout'),
                  onPressed: () async {
                    await AuthService().signOutUser();
                    // Navigator.pop(context);
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Root()));
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
