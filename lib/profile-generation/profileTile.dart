import 'package:flutter/material.dart';
import 'package:osint/profile-generation/profile.dart';

class ProfileTile extends StatefulWidget {
  final Profiless profiled;
  ProfileTile({this.profiled});
  @override
  _ProfileTileState createState() => _ProfileTileState();
}

class _ProfileTileState extends State<ProfileTile> {
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
                  '${widget.profiled.full_name}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  '${widget.profiled.bio}',
                  style: TextStyle(fontSize: 16, color: Colors.blueGrey[400]),
                ),
                SizedBox(height: 20),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text('Followers: ${widget.profiled.followers}',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text('Following: ${widget.profiled.following}',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                    ]),
                SizedBox(height: 5),
                Text(
                  '${widget.profiled.city}, ${widget.profiled.country}',
                  style: TextStyle(fontSize: 15, color: Colors.blueGrey[400]),
                ),
              ],
            )));
  }
}
