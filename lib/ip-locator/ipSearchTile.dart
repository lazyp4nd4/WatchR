import 'package:flutter/material.dart';
import 'package:osint/ip-locator/ipadd.dart';

class IPSearchTile extends StatefulWidget {
  final IPAdd ipadd;
  IPSearchTile({this.ipadd});

  @override
  _IPSearchTileState createState() => _IPSearchTileState();
}

class _IPSearchTileState extends State<IPSearchTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              '${widget.ipadd.ip}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              '${widget.ipadd.city}, ${widget.ipadd.country}',
              style: TextStyle(fontSize: 16, color: Colors.blueGrey[400]),
            ),
            SizedBox(height: 20),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Expanded(
                flex: 1,
                child: Text('Latitude: ${widget.ipadd.lat}',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              Expanded(
                flex: 1,
                child: Text('Longitude: ${widget.ipadd.lang}',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    )),
              ),
            ])
          ],
        ),
      ),
    );
  }
}
