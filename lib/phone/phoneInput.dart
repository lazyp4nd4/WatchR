import 'package:flutter/material.dart';
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
                        hintText: 'Phone Number with Country Code',
                        focusColor: Color(0xff1173F1),
                      ),
                      onChanged: (value) {
                        phone = value;
                      },
                    )
                  : Container(),
              received == false
                  ? ElevatedButton(
                      onPressed: () async {
                        final res = await http
                            .get(Uri.http("192.168.43.201:5000", "/3/$phone"));
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
                            result_phone = decoded;
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
                      ? Text('Location: ${result_phone["result"]["location"]}')
                      : Text('Some error')
                  : Container(),
              SizedBox(
                height: 30,
              ),
              received == true
                  ? error == false
                      ? Text(
                          'Country: ${result_phone["result"]["country_name"]}')
                      : Text('Some error')
                  : Container(),
              SizedBox(
                height: 30,
              ),
              received == true
                  ? error == false
                      ? Text('Carrier: ${result_phone["result"]["carrier"]}')
                      : Text('Some error')
                  : Container(),
              SizedBox(
                height: 30,
              ),
              received == true
                  ? error == false
                      ? Text(
                          'Line Type: ${result_phone["result"]["line_type"]}')
                      : Text('Some error')
                  : Container(),
              SizedBox(
                height: 30,
              ),
              received == true
                  ? error == false
                      ? ElevatedButton(
                          onPressed: () async {
                            await DatabaseServices(uid).addPhoneNumberLocations(
                                result_phone["result"]["location"],
                                result_phone["result"]["carrier"],
                                result_phone["result"]["country_name"],
                                result_phone["result"]["line_type"],
                                result_phone["result"]["number"]);
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
                              'Locate Another Phone!',
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
