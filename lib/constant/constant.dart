 import 'package:flutter/material.dart';

const Kstyling = TextStyle(fontWeight: FontWeight.bold, fontSize: 40);
const kTextFieldInputDecoration = InputDecoration(
  hintText: 'Enter the city Name',
  hintStyle: TextStyle(
    color: Colors.black,
  ),
  filled: true,
  fillColor: Colors.white,
  icon: Icon(
    Icons.location_city,
    color: Colors.white,
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(10),
    ),
    borderSide: BorderSide.none,
  ),
);
