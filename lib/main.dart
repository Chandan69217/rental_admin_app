import 'package:flutter/material.dart';
import 'package:rental_admin_app/screens/dashboard.dart';
import 'package:rental_admin_app/screens/hostel_floors.dart';
import 'package:rental_admin_app/screens/profile.dart';
import 'package:rental_admin_app/screens/room_availability.dart';
import 'package:rental_admin_app/utilities/theme_data.dart';
import 'package:sizing/sizing.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizingBuilder(
      builder: () { return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: custThemeData(),
        home: const Dashboard(),
      );},
    );
  }
}

