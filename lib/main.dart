import 'package:flutter/material.dart';
import './ui/klimatic_states.dart';


void main() {
  runApp(new MaterialApp(
     title: "Klimatic Weather App",
    theme: ThemeData(fontFamily: 'Radley'),
    home: new Klimatic(),
  ) );
}