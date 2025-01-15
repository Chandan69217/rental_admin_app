import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rental_admin_app/screens/dashboard.dart';
import 'package:rental_admin_app/screens/hostel_floors.dart';
import 'package:rental_admin_app/screens/login_register_screen.dart';
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
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark
      ),
      child: SizingBuilder(
        builder: () { return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: custThemeData(),
          home: LoginRegisterScreen()
          //const Dashboard(),
        );},
      ),
    );
  }

}

Future<void> initHive() async {
  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
}

