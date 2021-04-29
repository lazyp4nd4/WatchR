import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:osint/config/palette.dart';
import 'package:osint/hunter/hunters.dart';
import 'package:osint/hunter/inputHunter.dart';
import 'package:osint/ip-locator/ipAddress.dart';
import 'package:osint/ip-locator/ips.dart';
import 'package:osint/phone/phoneInput.dart';
import 'package:osint/phone/phones.dart';
import 'package:osint/profile-generation/inputDetails.dart';
import 'package:osint/root.dart';
import 'package:osint/services/authService.dart';

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
        backgroundColor: Color(0xffFFF7EB),
        buttonBackgroundColor: Palette.darkOrange,
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
            color: Color(0xffFFF7EB),
          ),
          Icon(
            Icons.home_outlined,
            color: Color(0xffFFF7EB),
          ),
          Icon(
            Icons.phone_outlined,
            color: Color(0xffFFF7EB),
          ),
          Icon(
            Icons.verified_user_outlined,
            color: Color(0xffFFF7EB),
          )
        ],
      ),
      body: _page == 0
          ? IPs()
          : _page == 1
              ? HomeMain()
              : _page == 2
                  ? Phones()
                  : Hunters(),
    );
  }
}

class HomeMain extends StatefulWidget {
  @override
  _HomeMainState createState() => _HomeMainState();
}

class _HomeMainState extends State<HomeMain> with TickerProviderStateMixin {
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
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        actions: [
          IconButton(
              onPressed: () async {
                await AuthService().signOutUser();
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => Root()));
              },
              icon: Icon(
                Icons.logout,
                color: Palette.darkOrange,
              ))
        ],
        title: Text(
          'Home',
          style:
              TextStyle(color: Palette.darkOrange, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => IPAddress()));
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Stack(alignment: Alignment.center, children: [
                              Image(
                                  image: AssetImage("assets/green.png"),
                                  height: 220),
                              Column(
                                children: [
                                  Image(
                                    image: AssetImage("assets/map.png"),
                                    height: 200,
                                  ),
                                  Text("Locate IP",
                                      style: TextStyle(
                                          color: Palette.darkBlue,
                                          fontWeight: FontWeight.bold)),
                                ],
                              )
                            ]),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => InputHunter()));
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Stack(alignment: Alignment.center, children: [
                              Image(
                                  image: AssetImage("assets/orange.png"),
                                  height: 220),
                              Column(
                                children: [
                                  Image(
                                      image: AssetImage("assets/hunter.png"),
                                      height: 200),
                                  Text("Generate Profile",
                                      style: TextStyle(
                                          color: Palette.darkBlue,
                                          fontWeight: FontWeight.bold))
                                ],
                              )
                            ]),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PhoneInput()));
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Stack(alignment: Alignment.center, children: [
                              Image(
                                  image: AssetImage("assets/blue.png"),
                                  height: 200),
                              Column(
                                children: [
                                  Image(
                                    image: AssetImage("assets/phone.png"),
                                    height: 180,
                                  ),
                                  Text("Locate Phone Number",
                                      style: TextStyle(
                                          color: Palette.darkBlue,
                                          fontWeight: FontWeight.bold))
                                ],
                              )
                            ]),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => InputDetails()));
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Stack(alignment: Alignment.center, children: [
                              Image(
                                  image: AssetImage("assets/orange.png"),
                                  height: 220),
                              Column(
                                children: [
                                  Image(
                                    image: AssetImage("assets/instagram.png"),
                                    height: 100,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text("Generate Social Media Profile",
                                      style: TextStyle(
                                          color: Palette.darkBlue,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ])
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
