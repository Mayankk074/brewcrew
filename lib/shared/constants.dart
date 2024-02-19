import 'package:flutter/material.dart';

const textInputDecoration =InputDecoration(
  fillColor: Colors.white,
  filled: true,
  errorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(28.0)),
    borderSide: BorderSide(
      color: Colors.white,
      width: 2.0,
    ),
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(28.0)),
    borderSide: BorderSide(
      color: Colors.white,
      width: 2.0,
    ),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(28.0)),
    borderSide: BorderSide(
      color: Colors.white,
      width: 2.0,
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(28.0)),
    borderSide: BorderSide(
      color: Colors.pink,
      width: 2.0,
    ),
  ),
);