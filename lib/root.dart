import 'package:flutter/material.dart';
import 'package:osint/screens/auth/auth_scree.dart';
import 'package:osint/home.dart';
import 'package:osint/model/loading.dart';
import 'package:osint/services/sharedPreferences.dart';

class Root extends StatefulWidget {
  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {
  bool signedIn = false;
  bool loading = false;
  Future<void> checkStatus() async {
    String uid = await SharedFunctions.getUserUid();
    if (uid != null) {
      setState(() {
        signedIn = true;
      });
    } else
      signedIn = false;
    setState(() {
      loading = true;
    });
  }

  @override
  void initState() {
    super.initState();
    checkStatus();
  }

  @override
  Widget build(BuildContext context) {
    if (signedIn) {
      return Home();
    } else {
      return AuthScreen();
    }
  }
}
