import 'package:flutter/material.dart';
import 'package:osint/hunter/inputHunter.dart';
import 'package:osint/ip-locator/ipAddress.dart';
import 'package:osint/model/loading.dart';
import 'package:osint/model/navDrawer.dart';
import 'package:http/http.dart' as http;
import 'package:osint/profile-generation/inputDetails.dart';
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
      appBar: AppBar(
        title: Text('OSInt'),
      ),
      drawer: NavDrawer(),
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
            ],
          ),
        ),
      ),
    );
  }
}
