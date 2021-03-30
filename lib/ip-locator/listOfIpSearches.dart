import 'package:flutter/material.dart';
import 'package:osint/config/palette.dart';
import 'package:osint/ip-locator/ipSearchTile.dart';
import 'package:osint/ip-locator/ipadd.dart';
import 'package:provider/provider.dart';

class IPSearchList extends StatefulWidget {
  @override
  _IPSearchListState createState() => _IPSearchListState();
}

class _IPSearchListState extends State<IPSearchList> {
  @override
  Widget build(BuildContext context) {
    final ips = Provider.of<List<IPAdd>>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: Text(
          'Previous IPs Located',
          style: TextStyle(color: Palette.darkBlue),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 8),
        child: ListView.builder(
          itemCount: ips.length,
          itemBuilder: (context, index) {
            return IPSearchTile(
              ipadd: ips[index],
            );
          },
        ),
      ),
    );
  }
}
