import 'package:flutter/material.dart';
import 'package:osint/config/palette.dart';
import 'package:osint/model/navDrawer.dart';
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
  Map<String, dynamic> result_ip;
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
          title: Text('IP Locator', style: TextStyle(color: Palette.darkBlue)),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Palette.darkBlue,
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
                height: 100,
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
                        hintText: 'IP Address',
                        focusColor: Color(0xff1173F1),
                      ),
                      onChanged: (value) {
                        ip = value;
                      },
                    )
                  : Container(),
              received == false
                  ? ElevatedButton(
                      onPressed: () async {
                        final res = await http
                            .get(Uri.http("192.168.1.4:5000", "/1/$ip"));
                        dynamic decoded = convert.jsonDecode(res.body)
                            as Map<String, dynamic>;

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
                            borderRadius: BorderRadius.circular(10)),
                        width: double.infinity,
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Text(
                          'Locate!',
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
                      ? Text('City: ${result_ip["location"][0]["city"]}')
                      : Text('Some error')
                  : Container(),
              SizedBox(
                height: 30,
              ),
              received == true
                  ? error == false
                      ? Text('Country: ${result_ip["location"][0]["country"]}')
                      : Text('Some error')
                  : Container(),
              SizedBox(
                height: 30,
              ),
              received == true
                  ? error == false
                      ? Text(
                          'Service Provider: ${result_ip["autonomous_system"]["name"]}')
                      : Text('Some error')
                  : Container(),
              SizedBox(
                height: 30,
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
                                target: LatLng(
                                    result_ip["location"][0]["latitude"],
                                    result_ip["location"][0]["longitude"])),
                          ),
                        )
                      : Text("Some error")
                  : Container(),
              received == true
                  ? error == false
                      ? ElevatedButton(
                          onPressed: () async {
                            await DatabaseServices(uid).addIP(
                                result_ip["location"][0]["city"],
                                result_ip["location"][0]["country"],
                                result_ip["autonomous_system"]["name"],
                                ip,
                                result_ip["location"][0]["latitude"],
                                result_ip["location"][0]["longitude"]);
                            setState(() {
                              received = false;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10)),
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
                        )
                      : Text('Some error')
                  : Container(),
            ],
          ),
        ),
      )),
    );
  }
}
