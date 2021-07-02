import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:osint/config/palette.dart';
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
  bool loading = false;
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
          title: Text('Profile Generator',
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
                      Image(
                          image: AssetImage("assets/orange.png"), height: 220),
                      Column(
                        children: [
                          Image(
                            image: AssetImage("assets/hunter.png"),
                            height: 250,
                          ),
                          Text("Generate Profile",
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
              // to enter data
              loading == false
                  ? received == false
                      ? Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
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
                                  hintText: 'First Name',
                                  focusColor: Palette.darkBlue,
                                ),
                                onChanged: (value) {
                                  first = value;
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
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
                                  hintText: 'Last Name',
                                  focusColor: Palette.darkBlue,
                                ),
                                onChanged: (value) {
                                  last = value;
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
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
                                  hintText: 'Domain',
                                  focusColor: Palette.darkBlue,
                                ),
                                onChanged: (value) {
                                  domain = value;
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              // ignore: deprecated_member_use
                              child: FlatButton(
                                onPressed: () async {
                                  setState(() {
                                    loading = true;
                                  });
                                  final res = await http.get(Uri.http(
                                      "watchrosint51.herokuapp.com",
                                      "/2/$first/$last/$domain"));
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
                                      result = decoded;
                                      received = true;
                                    });
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Palette.lightBlue,
                                      borderRadius: BorderRadius.circular(10)),
                                  width: double.infinity,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  child: Text(
                                    'Generate Profile!',
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
                      :
                      //to display data
                      error == false
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
                                      fontSize: 16,
                                      color: Colors.blueGrey[400]),
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
                                Row(
                                  children: [
                                    Text(
                                      'Confidence: ${result["data"]["score"]}',
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.blueGrey[400]),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                // ignore: deprecated_member_use
                                FlatButton(
                                  onPressed: () async {
                                    await DatabaseServices(uid)
                                        .addHunterProfile(
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
                                        color: Palette.lightBlue,
                                        borderRadius:
                                            BorderRadius.circular(10)),
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
                                ),
                              ],
                            )
                          : Center(
                              child: Text(
                                  "Some error occured!\nPlease try again later."),
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
