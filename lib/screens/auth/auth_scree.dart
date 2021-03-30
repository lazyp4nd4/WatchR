import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:osint/authentication/login.dart';
import 'package:osint/authentication/register.dart';
import 'package:osint/screens/background_painting.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  ValueNotifier<bool> showSignInPage = ValueNotifier<bool>(true);

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: CustomPaint(
              painter: BackgroundPainter(animation: _controller.view),
            ),
          ),
          Center(
            child: ValueListenableBuilder<bool>(
              valueListenable: showSignInPage,
              builder: (context, value, child) {
                return PageTransitionSwitcher(
                  reverse: !value,
                  duration: Duration(milliseconds: 800),
                  transitionBuilder: (child, animation, secondaryAnimation) {
                    return SharedAxisTransition(
                        animation: animation,
                        fillColor: Colors.transparent,
                        secondaryAnimation: secondaryAnimation,
                        transitionType: SharedAxisTransitionType.vertical,
                        child: child);
                  },
                  child: value
                      ? Login(
                          onRegisterClicked: () {
                            showSignInPage.value = false;
                            _controller.forward();
                          },
                        )
                      : Register(
                          onSignInPressed: () {
                            showSignInPage.value = true;
                            _controller.reverse();
                          },
                        ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
