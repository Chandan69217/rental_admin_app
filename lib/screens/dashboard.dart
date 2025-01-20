import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:rental_admin_app/models/dashboard_data.dart';
import 'package:rental_admin_app/screens/assign_room.dart';
import 'package:rental_admin_app/screens/attendance_history.dart';
import 'package:rental_admin_app/screens/hostel_floors.dart';
import 'package:rental_admin_app/screens/profile.dart';
import 'package:rental_admin_app/screens/student_screen.dart';
import 'package:rental_admin_app/utilities/base64_converter.dart';
import 'package:rental_admin_app/utilities/cust_color.dart';
import 'package:rental_admin_app/utilities/urls.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizing/sizing.dart';
import '../utilities/consts.dart';
import '../utilities/store_to_cache.dart';
import '../widgets/cust_circular_indicator.dart';
import 'home_screen.dart';


class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _currentIndex = 0;
  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  _fetchData()async{
    final connectivityResult = await Connectivity().checkConnectivity();
    if(!(connectivityResult.contains(ConnectivityResult.mobile)||connectivityResult.contains(ConnectivityResult.wifi)||connectivityResult.contains(ConnectivityResult.ethernet))){
      Fluttertoast.showToast(msg: 'No internet connection');
      return;
    }
    var pref = await SharedPreferences.getInstance();
    var token = pref.getString(Consts.Token)??'';
    try{
      if(token.isEmpty){
        print('user token not available');
        return;
      }
      final getProfileUri =  Uri.https(Urls.baseUrl,Urls.getProfileUrl);
      final getHostelListUri =  Uri.https(Urls.baseUrl,Urls.getHostelInfoUrl);

      final responses = await Future.wait([
        get(getProfileUri,headers: {
          'authorization': 'bearer ${Urls.token}',
          'content_type' : 'application/json'
        }),
        get(getHostelListUri,headers: {
          'authorization': 'bearer ${Urls.token}',
          'content_type' : 'application/json'
        }),
      ]);

      if(responses[0].statusCode == 200 && responses[1].statusCode == 200){
        final profileData = json.decode(responses[0].body) as Map<String,dynamic>;
        final hostelData = json.decode(responses[1].body) as Map<String,dynamic>;
        await storeUserData(to: 'dashboardBox', key: 'userProfile',userData: profileData['data']['result']);
        await storeUserData(to: 'dashboardBox', key: 'hostelList',userData: hostelData['data']);
        setState(() {});
      }else{
        if(responses[0].statusCode == 200){
          final profileBody = json.decode(responses[0].body) as Map<String,dynamic>;
          await storeUserData(to: 'dashboardBox',key: 'userProfile',userData: profileBody['data']['result']);
        }else {
          print('Profile API failed with status: ${responses[0].statusCode}, Reason: ${responses[0].reasonPhrase}');
        }
        if(responses[1].statusCode == 200){
          final hostelBody = json.decode(responses[1].body) as Map<String,dynamic>;
          await storeUserData(to: 'dashboardBox', key: 'hostelList',userData: hostelBody['data']);
        }else{
          print('Hostel List API failed with status: ${responses[1].statusCode}, Reason: ${responses[1].reasonPhrase}');
        }
        setState(() {});
      }
    }catch(exception,trace){
      print('Error: ${exception.toString()}');
      print('Stack trace: $trace');
    }
  }

  Future<bool> getFromCachedMemory() async {
    var pref = await SharedPreferences.getInstance();
    DashboardData.token = pref.getString(Consts.Token);
    try {
      var cachedProfileData = await getUserData(from: 'dashboardBox', key: 'userProfile');
      if (cachedProfileData != null) {
        DashboardData.profile = base64ToImage(cachedProfileData['hostelAdminProfileImage']);
        DashboardData.Name = cachedProfileData['hostelAdminName'];
        DashboardData.MobileNo = cachedProfileData['hostelAdminPhoneNumber'];
        DashboardData.EmailID = cachedProfileData['hostelAdminEmail'];
        DashboardData.Password = cachedProfileData['hostelAdminPassword'];
        DashboardData.Role = cachedProfileData['hostelAdminRole'];
        DashboardData.user_id = cachedProfileData['id'];
      }else {
        print('Error: cachedHostelData is null or not a Map<String, dynamic>.');
      }

      var cachedHostelData = await getUserData(from: 'dashboardBox', key: 'hostelList');
      if (cachedHostelData != null) {
        var hostelList = cachedHostelData['hostelList'];
        if (hostelList is List) {
          DashboardData.hostels = List<Map<String, dynamic>>.from(
              hostelList.map((item) {
                if (item is Map<String, dynamic>) {
                  return item;
                } else if (item is Map) {
                  return Map<String, dynamic>.from(item);
                } else {
                  return <String, dynamic>{};
                }
              })
          );
        } else {
          print('Error: hostelList is not a valid list.');
        }
      } else {
        print('Error: cachedHostelData is null or not a Map<String, dynamic>.');
      }
    } catch (exception, trace) {
      print('Error fetching cached data: ${exception.toString()}, Trace: $trace');
    }
    return true;
  }
  List<Widget> _screens = [];
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getFromCachedMemory(),
      builder: (context,snapshot){
        if(snapshot.hasData){
         _screens =  [HomeScreen(),StudentScreen(),AttendanceHistory(),AssignRoom()];
        }
       return Scaffold(
        backgroundColor: CustColor.Background,
        appBar: AppBar(
          backgroundColor: CustColor.Green,
          foregroundColor: Colors.white,
          titleSpacing: 0,
          leading: Builder(
            builder: (BuildContext context) {
              // Wrap the IconButton inside a Builder to get a proper context
              return IconButton(
                onPressed: () => Scaffold.of(context).openDrawer(),
                icon: Icon(Icons.menu_rounded),
              );
            },
          ),
          title: Row(
            children: [
              Text(DashboardData.Name!=null?'Hi ${DashboardData.Name}':'',style:Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white)),
            ],
          ),
          actions: [
            // IconButton(
            //   icon: Icon(FontAwesomeIcons.bell,size: 20.ss,),
            //   onPressed: () {},
            // ),
            GestureDetector(
              onTap: ()=> Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Profile())),
              child: CircleAvatar(
                backgroundImage:
                DashboardData.profile??const AssetImage('assets/icons/dummy_profile.webp'),
                radius: 20.ss,
              ),
            ),
            SizedBox(width: 20.ss),
          ],
        ),
        body: !snapshot.hasData ?Center(child: CustCircularIndicator()) : _screens[_currentIndex],
         drawer: Drawer(backgroundColor: CustColor.Background,
           shape: RoundedRectangleBorder(),
           child: Column(),),
         bottomNavigationBar: BottomNavigationBar(
           backgroundColor: CustColor.Background,
             type: BottomNavigationBarType.fixed,
             selectedFontSize: 12,
             unselectedFontSize: 12,
             selectedItemColor: CustColor.Green,
             unselectedItemColor: CustColor.Gray,
             onTap: (selectedIndex){
               setState(() {
                 _currentIndex = selectedIndex;
               });
             },
             currentIndex: _currentIndex,
             items:  <BottomNavigationBarItem>[
           BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.home), label: 'Home'),
               BottomNavigationBarItem(icon: Icon( FontAwesomeIcons.userGraduate), label: 'Student'),
           BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.clipboardList), label: 'Attendance'),
           BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.plusCircle), label: 'Assign Room'),

         ]),
      );
      }
    );
  }
  
}

class ButtonsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      childAspectRatio: 2.9,
      shrinkWrap: true,
      crossAxisCount: 2,
      mainAxisSpacing: 10.ss,
      crossAxisSpacing: 10.ss,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        //DashboardButton(label: ' Wardens', icon: FontAwesomeIcons.userShield),
        DashboardButton(label: 'Students', icon: FontAwesomeIcons.userGraduate),
        DashboardButton(label: 'Attendance', icon: FontAwesomeIcons.clipboardList,onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=> AttendanceHistory())),),
        DashboardButton(label: 'Assign Room', icon: FontAwesomeIcons.plusCircle,onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=> AssignRoom()))),
      ],
    );
  }
}

class DashboardButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback? onTap;
  DashboardButton({required this.label, required this.icon,this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(8.ss),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Color(0xFFE0E0E0)),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(flex:1,child: Icon(icon, size: 24, color: Color(0xFF2E7D32))),
            SizedBox(width: 2.ss,),
            Expanded(flex:3,child: Text(label, style: Theme.of(context).textTheme.bodySmall)),
            Expanded(flex:1,child: Icon(Icons.keyboard_arrow_right_rounded,color: CustColor.Gray,))
          ],
        ),
      ),
    );
  }
}


