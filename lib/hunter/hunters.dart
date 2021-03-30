import 'package:flutter/material.dart';
import 'package:osint/hunter/hunter.dart';
import 'package:osint/hunter/listHunter.dart';
import 'package:osint/services/databaseService.dart';
import 'package:osint/services/sharedPreferences.dart';
import 'package:provider/provider.dart';

class Hunters extends StatefulWidget {
  @override
  _HuntersState createState() => _HuntersState();
}

class _HuntersState extends State<Hunters> {
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
      body: StreamProvider<List<Hunter>>.value(
        initialData: [],
        value: DatabaseServices(uid).hunterProfiles,
        child: Scaffold(
          body: HunterList(),
        ),
      ),
    );
  }
}
