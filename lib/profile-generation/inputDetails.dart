import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:osint/model/navDrawer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:osint/services/databaseService.dart';
import 'package:osint/services/sharedPreferences.dart';

class InputDetails extends StatefulWidget {
  @override
  _InputDetailsState createState() => _InputDetailsState();
}

class _InputDetailsState extends State<InputDetails> {
  String username;
  String ip;
  bool received = false;
  bool error = false;
  // ignore: non_constant_identifier_names
  Map<String, dynamic> result_ip;
  // ignore: non_constant_identifier_names
  Map<String, dynamic> result_profile;
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
      appBar: AppBar(
        title: Text('Profile Generation'),
      ),
      drawer: NavDrawer(),
      body: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          received == false
              ? TextField(
                  keyboardType: TextInputType.text,
                  enabled: true,
                  decoration: InputDecoration(
                    fillColor: Color(0xffE0E4F2),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xff1173F1),
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Color(0xff1173F1))),
                    hintText: 'Instagram Username',
                    focusColor: Color(0xff1173F1),
                  ),
                  onChanged: (value) {
                    username = value;
                  },
                )
              : Container(),
          SizedBox(
            height: 20,
          ),
          received == false
              ? TextField(
                  keyboardType: TextInputType.text,
                  enabled: true,
                  decoration: InputDecoration(
                    fillColor: Color(0xffE0E4F2),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xff1173F1),
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Color(0xff1173F1))),
                    hintText: 'IP address',
                    focusColor: Color(0xff1173F1),
                  ),
                  onChanged: (value) {
                    username = value;
                  },
                )
              : Container(),
          received == false
              ? ElevatedButton(
                  onPressed: () async {
                    final res = await http
                        .get(Uri.http("192.168.1.4:5000", "/2/$username"));
                    dynamic decoded =
                        convert.jsonDecode(res.body) as Map<String, dynamic>;
                    final res1 =
                        await http.get(Uri.http("192.168.1.3:5000", "/1/$ip"));
                    dynamic decoded1 =
                        convert.jsonDecode(res1.body) as Map<String, dynamic>;

                    if (res == null) {
                      setState(() {
                        error = true;
                        received = true;
                      });
                    } else {
                      setState(() {
                        received = true;
                        result_ip = decoded;
                        result_profile = decoded1;
                      });
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xff1173F1),
                        borderRadius: BorderRadius.circular(10)),
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Text(
                      'Find!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              : Container(),
          received == true
              ? error == false
                  ? Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: NetworkImage(
                                "${result_profile["user"]["profile_pic_url_hd"]}"),
                            fit: BoxFit.fill),
                      ))
                  : Text('Some error')
              : Container(),
          SizedBox(
            height: 5,
          ),
          received == true
              ? error == false
                  ? Text('Name: ${result_profile["user"]["full_name"]}')
                  : Text('Some error')
              : Container(),
          SizedBox(
            height: 5,
          ),
          received == true
              ? error == false
                  ? Text('Bio: ${result_profile["user"]["biography"]}')
                  : Text('Some error')
              : Container(),
          SizedBox(
            height: 5,
          ),
          received == true
              ? error == false
                  ? Text(
                      'Follower: ${result_profile["user"]["edge_followed_by"]["count"]}')
                  : Text('Some error')
              : Container(),
          SizedBox(
            height: 5,
          ),
          received == true
              ? error == false
                  ? Text(
                      'Following: ${result_profile["user"]["edge_follow"]["count"]}')
                  : Text('Some error')
              : Container(),
          SizedBox(
            height: 5,
          ),
          received == true
              ? error == false
                  ? Text('City: ${result_ip["location"]["city"]}')
                  : Text('Some error')
              : Container(),
          SizedBox(
            height: 5,
          ),
          received == true
              ? error == false
                  ? Text('Country: ${result_ip["location"]["country"]}')
                  : Text('Some error')
              : Container(),
          SizedBox(
            height: 5,
          ),
          received == true
              ? error == false
                  ? Container(
                      width: double.infinity,
                      height: 500,
                      padding: EdgeInsets.all(20),
                      child: GoogleMap(
                        initialCameraPosition: CameraPosition(
                            zoom: 8,
                            target: LatLng(result_ip["location"][0]["latitude"],
                                result_ip["location"][0]["longitude"])),
                      ),
                    )
                  : Text("Some error")
              : Container(),
          received == true
              ? error == false
                  ? ElevatedButton(
                      onPressed: () async {
                        //photo_url, full_name, followers, following, bio, username
                        await DatabaseServices(uid).addProfile(
                          result_ip["location"][0]["city"],
                          result_ip["location"][0]["country"],
                          result_ip["autonomous_system"]["name"],
                          ip,
                          result_ip["location"][0]["latitude"],
                          result_ip["location"][0]["longitude"],
                          result_profile["user"]["profile_pic_url_hd"],
                          result_profile["user"]["full_name"],
                          result_profile["user"]["edge_followed_by"]["count"],
                          result_profile["user"]["edge_follow"]["count"],
                          result_profile["user"]["biography"],
                          username,
                        );
                        setState(() {
                          received = false;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        width: double.infinity,
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Text(
                          'Generate new Profile',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  : Text('Some error')
              : Container(),
        ],
      )),
    );
  }
}
