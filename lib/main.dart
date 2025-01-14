import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rental_admin_app/screens/dashboard.dart';
import 'package:rental_admin_app/screens/hostel_floors.dart';
import 'package:rental_admin_app/screens/profile.dart';
import 'package:rental_admin_app/screens/room_availability.dart';
import 'package:rental_admin_app/utilities/theme_data.dart';
import 'package:sizing/sizing.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await initHive();
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

Future<void> initHive() async {
  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
}

