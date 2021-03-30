import 'package:flutter/material.dart';
import 'package:osint/config/palette.dart';

InputDecoration registerInputDecoration({String hintText}) {
  return InputDecoration(
      contentPadding: const EdgeInsets.symmetric(vertical: 18),
      hintStyle: const TextStyle(color: Colors.white, fontSize: 18),
      hintText: hintText,
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white, width: 2),
      ),
      enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white)),
      errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Palette.orange)),
      focusedErrorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(width: 2, color: Palette.orange)),
      errorStyle: TextStyle(color: Colors.white));
}

InputDecoration signInInputDecoration({String hintText}) {
  return InputDecoration(
      contentPadding: const EdgeInsets.symmetric(vertical: 18),
      hintStyle: const TextStyle(color: Palette.orange, fontSize: 18),
      hintText: hintText,
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Palette.orange, width: 2),
      ),
      enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Palette.orange)),
      errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Palette.orange)),
      focusedErrorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(width: 2, color: Palette.darkOrange)),
      errorStyle: TextStyle(color: Colors.white));
}
