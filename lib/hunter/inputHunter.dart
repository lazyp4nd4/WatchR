import 'package:flutter/material.dart';
import 'package:osint/config/palette.dart';
import 'package:osint/model/navDrawer.dart';
import 'package:osint/services/databaseService.dart';
import 'package:osint/services/sharedPreferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class InputHunter extends StatefulWidget {
  @override
  _InputHunterState createState() => _InputHunterState();
}

class _InputHunterState extends State<InputHunter> {
  String first, last, domain;
  bool received = false;
  bool error = false;
  Map<String, dynamic> result;

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
      drawer: NavDrawer(),
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
                      Image(
                          image: AssetImage("assets/orange.png"), height: 220),
                      Column(
                        children: [
                          Image(
                            image: AssetImage("assets/hunter.png"),
                            height: 250,
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
                        hintText: 'First Name',
                        focusColor: Color(0xff1173F1),
                      ),
                      onChanged: (value) {
                        first = value;
                      },
                    )
                  : Container(),
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
                        hintText: 'Last Name',
                        focusColor: Color(0xff1173F1),
                      ),
                      onChanged: (value) {
                        last = value;
                      },
                    )
                  : Container(),
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
                        hintText: 'Domain',
                        focusColor: Color(0xff1173F1),
                      ),
                      onChanged: (value) {
                        domain = value;
                      },
                    )
                  : Container(),
              received == false
                  ? ElevatedButton(
                      onPressed: () async {
                        final res = await http.get(Uri.http(
                            "192.168.43.201:5000", "/2/$first/$last/$domain"));
                        dynamic decoded = convert.jsonDecode(res.body)
                            as Map<String, dynamic>;

                        if (res == null) {
                          setState(() {
                            error = true;
                            received = true;
                          });
                        } else {
                          setState(() {
                            result = decoded;
                            received = true;
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
                          'Generate Profile!',
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
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              '${result["data"]["first_name"]} ${result["data"]["last_name"]}',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              '${result["data"]["position"]}, ${result["data"]["company"]}',
                              style: TextStyle(
                                  fontSize: 16, color: Colors.blueGrey[400]),
                            ),
                            SizedBox(height: 20),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                        'Email: ${result["data"]["email"]}',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        )),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                        'Domain: ${result["data"]["domain"]}',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        )),
                                  ),
                                ]),
                            SizedBox(height: 5),
                            Text(
                              'Confidence: ${result["data"]["score"]}',
                              style: TextStyle(
                                  fontSize: 15, color: Colors.blueGrey[400]),
                            ),
                          ],
                        )
                      : Text('Some error')
                  : Container(),
              received == true
                  ? error == false
                      ? ElevatedButton(
                          onPressed: () async {
                            await DatabaseServices(uid).addHunterProfile(
                                result["data"]["first_name"],
                                result["data"]["last_name"],
                                result["data"]["domain"],
                                result["data"]["email"],
                                result["data"]["company"],
                                result["data"]["position"],
                                result["data"]["score"]);
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
                              'Generate New Profile!',
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
