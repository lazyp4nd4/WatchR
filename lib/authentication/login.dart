import 'package:flutter/material.dart';
import 'package:osint/config/decoration_function.dart';
import 'package:osint/config/palette.dart';
import 'package:osint/config/signup_bar.dart';
import 'package:osint/config/title.dart';
import 'package:osint/home.dart';
import 'package:osint/services/authService.dart';

class Login extends StatefulWidget {
  const Login({Key key, this.onRegisterClicked}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();

  final VoidCallback onRegisterClicked;
}

class _LoginState extends State<Login> {
  String email, password;
  AuthService _auth = AuthService();
  bool processing = false;

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
                  title: 'Welcome\nBack',
                ),
              )),
          Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: ListView(children: [
                  TextFormField(
                    decoration: signInInputDecoration(hintText: 'Email'),
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    onChanged: (value) {
                      setState(() {
                        email = value;
                      });
                    },
                  ),
                  TextFormField(
                    decoration: signInInputDecoration(hintText: 'Password'),
                    keyboardType: TextInputType.visiblePassword,
                    autocorrect: false,
                    obscureText: true,
                    onChanged: (value) {
                      setState(() {
                        password = value;
                      });
                    },
                  ),
                  SignInBar(
                      label: 'Sign In',
                      onPressed: () async {
                        setState(() {
                          processing = true;
                        });
                        var result =
                            await _auth.signInWithEmail(email, password);
                        setState(() {
                          processing = false;
                        });
                        if (result == true) {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) => Home()));
                        } else if (result == false) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.black,
                            content: Text(
                              "Could not Create User",
                              style: TextStyle(
                                  color: Colors.redAccent, letterSpacing: 0.5),
                            ),
                          ));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.black,
                            content: Text(
                              result.toString(),
                              style: TextStyle(
                                  color: Colors.redAccent, letterSpacing: 0.5),
                            ),
                          ));
                        }
                      },
                      isLoading: processing),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          child: Divider(
                        thickness: 1.3,
                      )),
                      Expanded(
                          child: Text(
                        'OR',
                        textAlign: TextAlign.center,
                      )),
                      Expanded(
                          child: Divider(
                        thickness: 1.3,
                      ))
                    ],
                  ),
                  // ignore: deprecated_member_use
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    // ignore: deprecated_member_use
                    child: OutlineButton(
                      splashColor: Colors.grey,
                      onPressed: () async {
                        setState(() {
                          processing = true;
                        });
                        var result = await _auth.signInWithGoogle();
                        setState(() {
                          processing = false;
                        });
                        if (result == true) {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) => Home()));
                        } else if (result == false) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.black,
                            content: Text(
                              "Could not Create User",
                              style: TextStyle(
                                  color: Colors.redAccent, letterSpacing: 0.5),
                            ),
                          ));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.black,
                            content: Text(
                              result.toString(),
                              style: TextStyle(
                                  color: Colors.redAccent, letterSpacing: 0.5),
                            ),
                          ));
                        }
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40)),
                      highlightElevation: 1,
                      borderSide: BorderSide(color: Colors.grey),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Image(
                                image: AssetImage("assets/google_logo.png"),
                                height: 20.0),
                            SizedBox(
                              width: 30,
                            ),
                            Text(
                              'Sign in with Google',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: InkWell(
                      splashColor: Colors.white,
                      onTap: () {
                        widget.onRegisterClicked?.call();
                      },
                      child: const Text('Don\'t have an account? Sign up!',
                          style: TextStyle(
                              fontSize: 16,
                              decoration: TextDecoration.underline,
                              color: Palette.darkBlue)),
                    ),
                  )
                ]),
              )),
        ],
      ),
    );
  }
}
