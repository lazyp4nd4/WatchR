import 'package:flutter/material.dart';
import 'package:osint/hunter/hunter.dart';

class HunterTile extends StatefulWidget {
  final Hunter hunterProfiled;
  HunterTile({this.hunterProfiled});
  @override
  _HunterTileState createState() => _HunterTileState();
}

class _HunterTileState extends State<HunterTile> {
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
                Row(
                  children: [
                    Text(
                      '${widget.hunterProfiled.first} ${widget.hunterProfiled.last}',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Spacer(),
                    if (widget.hunterProfiled.confidence > 95)
                      Icon(
                        Icons.verified,
                        color: Colors.blue,
                      )
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  '${widget.hunterProfiled.position}, ${widget.hunterProfiled.company}',
                  style: TextStyle(fontSize: 16, color: Colors.blueGrey[400]),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Text('Email:',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        )),
                    Spacer(),
                    Text('${widget.hunterProfiled.email}',
                        style: TextStyle(
                          fontSize: 15,
                        )),
                  ],
                ),
                Row(
                  children: [
                    Text('Domain:',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        )),
                    Spacer(),
                    Text('${widget.hunterProfiled.domain}',
                        style: TextStyle(
                          fontSize: 15,
                        )),
                  ],
                ),
              ],
            )));
  }
}
