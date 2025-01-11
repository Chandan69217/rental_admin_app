import 'package:flutter/material.dart';
import 'package:sizing/sizing.dart';

ThemeData custThemeData(){
  return ThemeData(
    textTheme: TextTheme(
      bodyMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w500,),
      bodySmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      bodyLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
    )
  );
}