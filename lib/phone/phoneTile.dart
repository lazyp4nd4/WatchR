import 'package:flutter/material.dart';
import 'package:osint/phone/phone.dart';

class PhoneTile extends StatefulWidget {
  final PhoneSt phonest;
  PhoneTile({this.phonest});
  @override
  _PhoneTileState createState() => _PhoneTileState();
}

class _PhoneTileState extends State<PhoneTile> {
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
                  '+${widget.phonest.phone_number} ',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  '${widget.phonest.location}, ${widget.phonest.country_name} ',
                  style: TextStyle(fontSize: 16, color: Colors.blueGrey[400]),
                ),
                SizedBox(height: 20),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text('Carrier: ${widget.phonest.carrier}',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text('Line Type: ${widget.phonest.line_type}',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                    ]),
              ],
            )));
  }
}
