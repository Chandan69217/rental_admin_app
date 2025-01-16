import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:rental_admin_app/models/dashboard_data.dart';
import 'package:rental_admin_app/screens/room_availability.dart';
import 'package:rental_admin_app/utilities/cust_color.dart';
import 'package:rental_admin_app/widgets/cust_circular_indicator.dart';
import 'package:rental_admin_app/widgets/warning_message.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizing/sizing.dart';
import '../utilities/urls.dart';

class HostelFloors extends StatefulWidget {
  final String title;
  final String subTitle;
  final int hostel_id;
  HostelFloors({required this.title,required this.subTitle,required this.hostel_id});

  @override
  State<HostelFloors> createState() => _HostelFloorsState();
}

class _HostelFloorsState extends State<HostelFloors> {
  Future<Map<String,dynamic>> _getDetails() async {
    var pref = await SharedPreferences.getInstance();
    final connectionResult = await Connectivity().checkConnectivity();
    if(!(connectionResult.contains(ConnectivityResult.mobile)||connectionResult.contains(ConnectivityResult.wifi)||connectionResult.contains(ConnectivityResult.ethernet))){
      return  Future.error({
        'title': 'No connection',
        'desc': 'Please check your internet connectivity and try again',
      });
    }
    if(DashboardData.token == null){
      return Future.error({
        'title': 'Something went wrong !!',
        'desc': 'Please restart the app and try again.',
      });
    }

    try{
      final token = DashboardData.token??'';
     //  Uri uri = Uri.https(Urls.baseUrl, Urls.floorDetailUrl, {'id': '${widget.hostel_id}'});
      Uri uri = Uri.https(Urls.baseUrl, Urls.floorDetailUrl, {'id': '1'});

      final response =  await get(uri,headers: {
        'authorization' : 'Bearer ${Urls.token}',
        'content_type' : 'application/json',
      });

      if(response.statusCode == 200){
        final rawBody = jsonDecode(response.body);
        if(rawBody['status'] == 'Success' && rawBody['hostels']['result']!=null){
          print('result is available');
          var result = {
            'result' : Map<String,dynamic>.from(rawBody['hostels']['result']),
          };
          return result;
        }else{
          return  Future.error({
            'title': 'Nothing to show.',
            'desc': '',
          });
        }
      }else{
        return  Future.error({
          'title': 'Something went wrong !!',
          'desc': 'Please retry after sometime',
        });
      }
    }catch(exception){
      print('Exception : $exception');
      return  Future.error({
        'title': 'Something went wrong !!',
        'desc': 'Please retry after sometime',
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: CustColor.Green,
          foregroundColor: Colors.white,
          titleSpacing: 0,
          leading: IconButton(onPressed: ()=>Navigator.of(context).pop(), icon: Icon(Icons.keyboard_arrow_left_rounded)),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.title, style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white)),
              Text(widget.subTitle, style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.white)),
            ],
          ),
        ),
        body: FutureBuilder( future: _getDetails(),
          builder: (context,snapshot){
            if(snapshot.hasData){
              print('${snapshot.data}');
             var floors =  List<Map<String,dynamic>>.from(snapshot.data!['result']['floors']).map((item){
                 return Map<String,dynamic>.from(item);
             }).toList();
              return Padding(
                padding: EdgeInsets.all(20.ss),
                child: GridView.builder(
                  itemCount: floors.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 1.6),
                  itemBuilder: (BuildContext context, int index) =>
                    floorCard('${floors[index]['floorName']}', '${widget.title}', floors[index]['totalFloorRoom'], floors[index]['floorTotalBed'], floors[index]['totalBedOccupied'],onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>RoomAvailability(details: {'floor_name':'1st Floor','name':'Amit Kumar','total_rooms':10},)))),

                ),
              );
            }else if(snapshot.hasError){
              var error = snapshot.error as Map<String,String>;
              return ShowWarning(titile: error['title']!,desc: error['desc']!, onPressed: _refresh,);
            }else{
              return Center(child: CustCircularIndicator(),);
            }
          }
        ),
      ),
    );
  }

  _refresh(){
    setState(() {});
  }

  Widget floorCard(String floor, String name, int rooms, int beds, int keys, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.ss)),
        color: CustColor.Light_Green,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Text(
                    floor,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Expanded(
                child: Row(
                  children: [
                    const Icon(FontAwesomeIcons.hotel, color: CustColor.Green, size: 16),
                    const SizedBox(width: 4), // Adds spacing between the icon and text
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    detailIcon(Icons.door_front_door, rooms.toString()),
                    detailIcon(Icons.bed, beds.toString()),
                    detailIcon(Icons.vpn_key, keys.toString()),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget detailIcon(IconData icon, String value) {
    return Row(
      children: [
        Icon(icon, size: 18, color: CustColor.Green),
        const SizedBox(width: 5),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
