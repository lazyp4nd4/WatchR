import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:osint/config/palette.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:osint/services/databaseService.dart';
import 'package:osint/services/sharedPreferences.dart';

class IPAddress extends StatefulWidget {
  @override
  _IPAddressState createState() => _IPAddressState();
}

class _IPAddressState extends State<IPAddress> {
  String ip;
  String username;
  bool received = false;
  bool error = false;
  bool loading = false;
  // ignore: non_constant_identifier_names
  Map<String, dynamic> result_ip;
  // ignore: non_constant_identifier_names
  Map<String, dynamic> result_instagram;
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
          title: Text('IP Locator',
              style: TextStyle(
                  color: Palette.darkOrange, fontWeight: FontWeight.bold)),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Palette.darkOrange,
              ))),
      body: SingleChildScrollView(
          child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(alignment: Alignment.center, children: [
                      Image(image: AssetImage("assets/green.png"), height: 220),
                      Column(
                        children: [
                          Image(
                            image: AssetImage("assets/map.png"),
                            height: 200,
                          ),
                          Text("Locate IP",
                              style: TextStyle(
                                  color: Palette.darkBlue,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ])
                  ]),
              SizedBox(
                height: 30,
              ),
              loading == false
                  ? received == false
                      ? Column(
                          children: [
                            TextField(
                              keyboardType: TextInputType.number,
                              enabled: true,
                              decoration: InputDecoration(
                                fillColor: Palette.lightBlue,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Palette.darkBlue, width: 2.0),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        BorderSide(color: Palette.lightBlue)),
                                hintText: 'IP Address',
                                focusColor: Palette.darkBlue,
                              ),
                              onChanged: (value) {
                                ip = value;
                              },
                            ),
                            // ignore: deprecated_member_use
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: FlatButton(
                                onPressed: () async {
                                  setState(() {
                                    loading = true;
                                  });
                                  final res = await http.get(Uri.http(
                                      "watchrosint51.herokuapp.com", "/1/$ip"));
                                  dynamic decoded = convert.jsonDecode(res.body)
                                      as Map<String, dynamic>;
                                  setState(() {
                                    loading = false;
                                  });
                                  if (res == null) {
                                    setState(() {
                                      error = true;
                                      received = true;
                                    });
                                  } else {
                                    setState(() {
                                      received = true;
                                      result_ip = decoded;
                                    });
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Palette.lightBlue,
                                      borderRadius: BorderRadius.circular(10)),
                                  width: double.infinity,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 0, vertical: 10),
                                  child: Text(
                                    'Locate!',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      : error == true
                          ? Center(child: Text("Some error occured!"))
                          : Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('City:'),
                                        Text(
                                          ' ${result_ip["location"][0]["city"]}',
                                          style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Country:'),
                                        Text(
                                          ' ${result_ip["location"][0]["country"]}',
                                          style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Service Provider:'),
                                        Text(
                                          ' ${result_ip["autonomous_system"]["name"]}',
                                          style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    width: double.infinity,
                                    height: 300,
                                    padding: EdgeInsets.all(20),
                                    child: GoogleMap(
                                      initialCameraPosition: CameraPosition(
                                          zoom: 8,
                                          target: LatLng(
                                              result_ip["location"][0]
                                                  ["latitude"],
                                              result_ip["location"][0]
                                                  ["longitude"])),
                                    ),
                                  ),
                                  // ignore: deprecated_member_use
                                  FlatButton(
                                    onPressed: () async {
                                      await DatabaseServices(uid).addIP(
                                          result_ip["location"][0]["city"],
                                          result_ip["location"][0]["country"],
                                          result_ip["autonomous_system"]
                                              ["name"],
                                          ip,
                                          result_ip["location"][0]["latitude"],
                                          result_ip["location"][0]
                                              ["longitude"]);
                                      setState(() {
                                        received = false;
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Palette.lightBlue,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      width: double.infinity,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      child: Text(
                                        'Locate Another IP!',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                  : SpinKitCircle(
                      color: Palette.lightBlue,
                      size: 100,
                    ),
            ],
          ),
        ),
      )),
    );
  }
}
