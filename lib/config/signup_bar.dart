import 'package:flutter/material.dart';
import 'package:osint/config/palette.dart';

class SignUpBar extends StatelessWidget {
  const SignUpBar(
      {Key key,
      @required this.label,
      @required this.onPressed,
      @required this.isLoading})
      : super(key: key);

  final String label;
  final VoidCallback onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  fontSize: 24),
            ),
            Center(
              child: LoadingIndicator(isLoading: isLoading),
            ),
            Center(
              child: RoundContinueButton(onPressed: onPressed),
            )
          ],
        ));
  }
}

class SignInBar extends StatelessWidget {
  const SignInBar(
      {Key key,
      @required this.label,
      @required this.onPressed,
      @required this.isLoading})
      : super(key: key);

  final String label;
  final VoidCallback onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  color: Palette.darkBlue,
                  fontSize: 24),
            ),
            Center(
              child: LoadingIndicator(isLoading: isLoading),
            ),
            Center(
              child: RoundContinueButton(onPressed: onPressed),
            )
          ],
        ));
  }
}

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({
    Key key,
    @required this.isLoading,
  }) : super(key: key);

  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 100),
        child: Visibility(
          child: const LinearProgressIndicator(
            backgroundColor: Palette.darkBlue,
          ),
          visible: isLoading,
        ));
  }
}

class RoundContinueButton extends StatelessWidget {
  const RoundContinueButton({
    Key key,
    @required this.onPressed,
  }) : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      elevation: 0.0,
      fillColor: Palette.darkBlue,
      splashColor: Palette.darkOrange,
      padding: EdgeInsets.all(22),
      shape: CircleBorder(),
      child: Icon(
        Icons.arrow_right_alt,
        color: Colors.white,
        size: 24,
      ),
    );
  }
}
