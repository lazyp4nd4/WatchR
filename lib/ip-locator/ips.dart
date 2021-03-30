import 'package:flutter/material.dart';
import 'package:osint/ip-locator/ipadd.dart';
import 'package:osint/ip-locator/listOfIpSearches.dart';
import 'package:osint/services/databaseService.dart';
import 'package:osint/services/sharedPreferences.dart';
import 'package:provider/provider.dart';

class IPs extends StatefulWidget {
  @override
  _IPsState createState() => _IPsState();
}

class _IPsState extends State<IPs> {
  String uid;
  Future<void> getUserUid() async {
    String u = await SharedFunctions.getUserUid();
    if (u != null) {
      setState(() {
        uid = u;
      });
    }
  }

  @override
  void initState() {
    getUserUid();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamProvider<List<IPAdd>>.value(
        initialData: [],
        value: DatabaseServices(uid).ips,
        child: Scaffold(
          body: IPSearchList(),
        ),
      ),
    );
  }
}
