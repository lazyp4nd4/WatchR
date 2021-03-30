import 'package:flutter/material.dart';
import 'package:osint/profile-generation/listOfSearchedProfiles.dart';
import 'package:osint/profile-generation/profile.dart';
import 'package:osint/services/databaseService.dart';
import 'package:osint/services/sharedPreferences.dart';
import 'package:provider/provider.dart';

class Profiles extends StatefulWidget {
  @override
  _ProfilesState createState() => _ProfilesState();
}

class _ProfilesState extends State<Profiles> {
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
      body: StreamProvider<List<Profiless>>.value(
        initialData: [],
        value: DatabaseServices(uid).profiles,
        child: Scaffold(
          body: ProfileList(),
        ),
      ),
    );
  }
}
