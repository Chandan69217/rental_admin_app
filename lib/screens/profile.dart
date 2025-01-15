import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rental_admin_app/screens/dashboard.dart';
import 'package:rental_admin_app/screens/login_register_screen.dart';
import 'package:rental_admin_app/utilities/cust_color.dart';
import 'package:rental_admin_app/widgets/cust_circular_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizing/sizing.dart';
import '../models/dashboard_data.dart';


class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool _isLoading = false;
  // ImageProvider? profile;
  // String? userName,mobileNo;
  @override
  void initState() {
    super.initState();
    // getFromCachedMemory();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: CustColor.Background,
        body: Column(
          children: [
            // Top Profile Design
            Stack(alignment: Alignment.topCenter, children: [
              Column(
                children: [
                  // AppBar Logic
                  Container(
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.centerLeft,
                    color: CustColor.Green,
                    child: SafeArea(
                        child: Column(children: [
                      IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: const Icon(
                            Icons.keyboard_arrow_left_rounded,
                            color: Colors.white,
                          )),
                      SizedBox(
                        height: 10.ss,
                      )
                    ])),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 35.ss),
                    margin: EdgeInsets.only(top: 15.ss),
                    width: MediaQuery.of(context).size.width,
                    child: Container(
                      padding: EdgeInsets.only(bottom: 20.ss),
                      decoration: BoxDecoration(
                        color: CustColor.Background,
                        borderRadius: BorderRadius.circular(20.ss),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 0.5,
                            spreadRadius: 0.1,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.edit,
                                color: Colors.black,
                                size: 20.ss,
                              ),
                            ),
                          ),
                          Text(
                            DashboardData.Name??'',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(fontSize: 24),
                          ),
                          Text(
                            'Chhoti Niwash',
                            style: Theme.of(context).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.normal,color: CustColor.Green),
                            // TextStyle(
                            //   fontSize: 16,
                            //   color: Colors.black54,
                            // ),
                          ),
                          Text(
                            DashboardData.MobileNo??'',
                            style: Theme.of(context).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.normal,color: CustColor.Gray),
                            // TextStyle(
                            //   fontSize: 16,
                            //   color: Colors.black54,
                            // ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SafeArea(
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: CustColor.Background, // Border color
                      width: 2.0, // Border width
                    ),),
                  child: CircleAvatar(
                    radius: 55.ss,
                    backgroundImage: DashboardData.profile??AssetImage('assets/icons/dummy_profile.webp'),
                  ),
                ),
              ),
            ]),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.ss),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ButtonsSection(),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(vertical: 20.ss),
                      padding: EdgeInsets.all(10.ss),
                      decoration: BoxDecoration(
                        color: CustColor.Background,
                        borderRadius: BorderRadius.circular(20.ss),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 0.5,
                            spreadRadius: 0.1,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: Text('Terms & Conditions'),
                            style:
                            TextButton.styleFrom(foregroundColor: CustColor.Gray,
                              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),  // Reduce vertical padding
                              minimumSize: Size(0, 30),
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text('Privacy Policy'),
                            style: TextButton.styleFrom(foregroundColor: CustColor.Gray,
                              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),  // Reduce vertical padding
                              minimumSize: Size(0, 10),
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text('Contact us'),
                            style: TextButton.styleFrom(foregroundColor: CustColor.Gray,
                              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),  // Reduce vertical padding
                              minimumSize: Size(0, 30),
                            ),
                          ),
                        ],
                      ),

                    ),


                  ],
                )
            ),
            logoutButton(),
          ],
        ),
      ),
    );
  }

  Widget logoutButton() {
   return _isLoading? CustCircularIndicator(): GestureDetector(
      onTap: _logout,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        width: 250,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.logout, color: CustColor.Green, size: 20),
            SizedBox(width: 5),
            Text(
              'Log Out',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 16)
            ),
          ],
        ),
      ),
    );
  }

  _logout() async{
    setState(() {
      _isLoading = true;
    });
    var pref = await SharedPreferences.getInstance();
    if(!await pref.clear()){
      Fluttertoast.showToast(msg: 'unable to logout');
      return;
    }
    var box = await Hive.openBox('dashboardBox');
    await box.deleteFromDisk();
    DashboardData.clearData();
    setState(() {
      _isLoading = false;
    });
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LoginRegisterScreen()), (route)=>false);
  }
}
