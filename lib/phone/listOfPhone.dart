import 'package:flutter/material.dart';
import 'package:osint/config/palette.dart';
import 'package:osint/phone/phone.dart';
import 'package:osint/phone/phoneTile.dart';
import 'package:provider/provider.dart';

class PhoneList extends StatefulWidget {
  @override
  _PhoneListState createState() => _PhoneListState();
}

class _PhoneListState extends State<PhoneList> {
  @override
  Widget build(BuildContext context) {
    final phones = Provider.of<List<PhoneSt>>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: Text(
          'Previous Phone Numbers Located',
          style:
              TextStyle(color: Palette.darkOrange, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 8),
        child: ListView.builder(
          itemCount: phones.length,
          itemBuilder: (context, index) {
            return PhoneTile(
              phonest: phones[index],
            );
          },
        ),
      ),
    );
  }
}
