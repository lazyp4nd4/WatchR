import 'package:flutter/material.dart';
import 'package:osint/config/decoration_function.dart';
import 'package:osint/config/palette.dart';
import 'package:osint/config/signup_bar.dart';
import 'package:osint/config/title.dart';
import 'package:osint/searchAndHome/home.dart';
import 'package:osint/services/authService.dart';

class Register extends StatefulWidget {
  const Register({Key key, this.onSignInPressed}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();

  final VoidCallback onSignInPressed;
}

class _RegisterState extends State<Register> {
  AuthService _auth = AuthService();
  String name, phoneNumber, email, password;
  bool processing = false;
  final formKey = GlobalKey<FormState>();

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              flex: 3,
              child: Align(
                alignment: Alignment.centerLeft,
                child: LoginTitle(
                  title: 'Create\nAccount',
                ),
              )),
          Expanded(
              flex: 4,
              child: ListView(children: [
                TextFormField(
                  decoration: registerInputDecoration(hintText: 'Name'),
                  style: TextStyle(color: Colors.white),
                  keyboardType: TextInputType.name,
                  autocorrect: false,
                  onChanged: (value) {
                    setState(() {
                      name = value;
                    });
                  },
                ),
                TextFormField(
                  decoration: registerInputDecoration(hintText: 'Phone Number'),
                  style: TextStyle(color: Colors.white),
                  keyboardType: TextInputType.phone,
                  autocorrect: false,
                  onChanged: (value) {
                    setState(() {
                      phoneNumber = value;
                    });
                  },
                ),
                TextFormField(
                  decoration: registerInputDecoration(hintText: 'Email'),
                  style: TextStyle(color: Colors.white),
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                  onChanged: (value) {
                    setState(() {
                      email = value;
                    });
                  },
                ),
                TextFormField(
                  decoration: registerInputDecoration(hintText: 'Password'),
                  style: TextStyle(color: Colors.white),
                  keyboardType: TextInputType.visiblePassword,
                  autocorrect: false,
                  onChanged: (value) {
                    setState(() {
                      password = value;
                    });
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SignUpBar(
                      label: 'Sign Up',
                      onPressed: () async {
                        setState(() {
                          processing = true;
                        });
                        bool ans = await _auth.registerWithEmail(
                            email, password, name, phoneNumber);
                        setState(() {
                          processing = true;
                        });
                        if (ans == true) {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) => Home()));
                        } else {
                          print("Not able to register");
                        }
                      },
                      isLoading: processing),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: InkWell(
                    splashColor: Colors.white,
                    onTap: () {
                      widget.onSignInPressed.call();
                    },
                    child: const Text('Sign In',
                        style: TextStyle(
                            fontSize: 16,
                            decoration: TextDecoration.underline,
                            color: Colors.white)),
                  ),
                )
              ])),
        ],
      ),
    );
  }
}
