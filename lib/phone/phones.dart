import 'package:flutter/material.dart';
import 'package:osint/phone/listOfPhone.dart';
import 'package:osint/phone/phone.dart';
import 'package:osint/services/databaseService.dart';
import 'package:osint/services/sharedPreferences.dart';
import 'package:provider/provider.dart';

class Phones extends StatefulWidget {
  @override
  _PhonesState createState() => _PhonesState();
}

class _PhonesState extends State<Phones> {
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
      body: StreamProvider<List<PhoneSt>>.value(
        initialData: [],
        value: DatabaseServices(uid).phoneNumbers,
        child: Scaffold(
          body: PhoneList(),
        ),
      ),
    );
  }
}
