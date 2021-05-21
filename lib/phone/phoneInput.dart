import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:osint/config/palette.dart';
import 'package:osint/services/databaseService.dart';
import 'package:osint/services/sharedPreferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class PhoneInput extends StatefulWidget {
  @override
  _PhoneInputState createState() => _PhoneInputState();
}

class _PhoneInputState extends State<PhoneInput> {
  String phone;
  bool received = false;
  bool error = false;
  bool loading = false;
  String carrier = "";
  String country = "";
  // ignore: non_constant_identifier_names
  Map<String, dynamic> result_phone;
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
          title: Text('Phone Number Locator',
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
                      Image(image: AssetImage("assets/blue.png"), height: 220),
                      Column(
                        children: [
                          Image(
                            image: AssetImage("assets/phone.png"),
                            height: 200,
                          ),
                          Text("Locate Phone Number",
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
                                hintText: 'Phone Number with Country Codes',
                                focusColor: Palette.darkBlue,
                              ),
                              onChanged: (value) {
                                phone = value;
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
                                  final res = await http.get(Uri.https(
                                      "watchrosint51.herokuapp.com",
                                      "/3/$phone"));
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
                                    List<String> tempCOuntry =
                                        decoded["country_name"].split(" ");

                                    List<String> tempCarrier =
                                        decoded["carrier"].split(" ");

                                    setState(() {
                                      received = true;
                                      result_phone = decoded;
                                      country = tempCOuntry.first;
                                      print(country);
                                      carrier = tempCarrier.first +
                                          " " +
                                          tempCarrier[1];
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
                                    'Locate!',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      : error == false
                          ? Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Location:'),
                                      Text(
                                        ' ${result_phone["location"]}',
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
                                        '$country',
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
                                      Text('Carrier:'),
                                      Text(
                                        '$carrier',
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
                                      Text('Line Type:'),
                                      Text(
                                        ' ${result_phone["line_type"]}',
                                        style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                                // ignore: deprecated_member_use
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  // ignore: deprecated_member_use
                                  child: FlatButton(
                                    onPressed: () async {
                                      await DatabaseServices(uid)
                                          .addPhoneNumberLocations(
                                              result_phone["location"],
                                              result_phone["carrier"],
                                              result_phone["country_name"],
                                              result_phone["line_type"],
                                              result_phone[
                                                  "international_format"]);
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
                                        'Locate Another Phone!',
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
                          : Center(
                              child: Text("Some error occured!"),
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
