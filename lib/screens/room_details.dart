import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:rental_admin_app/widgets/cust_circular_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizing/sizing.dart';

import '../models/dashboard_data.dart';
import '../utilities/cust_color.dart';
import '../utilities/urls.dart';
import '../widgets/warning_message.dart';

class RoomDetails extends StatefulWidget {
  final floorId;
  final floorName;
  final buildingName;
  RoomDetails({required this.floorId,required this.floorName,required this.buildingName});

  @override
  State<RoomDetails> createState() => _RoomDetailsState();
}

class _RoomDetailsState extends State<RoomDetails> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: CustColor.Background,
        appBar: AppBar(
          backgroundColor: CustColor.Green,
          foregroundColor: Colors.white,
          title:
          Text('${widget.floorName}',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Colors.white,)),
          titleSpacing: 0,
          leading: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(Icons.keyboard_arrow_left_rounded)),
        ),
        body: FutureBuilder(future: _getRooms(),
            builder: (context,snapshot){
          if(snapshot.hasData){
            var rooms =  List<Map<String,dynamic>>.from(snapshot.data!['result']['rooms']).map((item){
              return Map<String,dynamic>.from(item);
            }).toList();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 20.ss, vertical: 10.ss),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                            text: 'Total Rooms ',
                            style: Theme.of(context).textTheme.bodyLarge,
                            children: [
                              TextSpan(
                                  text: '(${rooms.length})',
                                  style: TextStyle(color: CustColor.Green))
                            ]),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Icon(
                            FontAwesomeIcons.hotel,
                            color: Colors.black,
                            size: 20,
                          ),
                          SizedBox(
                            width: 3.ss,
                          ),
                          Text('${widget.buildingName}',
                            //widget.details['name'],
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(color: CustColor.Green, fontSize: 16),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    padding:
                    EdgeInsets.symmetric(horizontal: 20.ss, vertical: 10.ss),
                    child: GridView.builder(
                      itemCount: rooms.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 1,),
                      itemBuilder: (BuildContext context, int index)=>
                        roomCard(roomNumber: rooms[index]['roomNumber'],totalBeds: rooms[index]['totalBed'],availableBeds: rooms[index]['totalBedOccupied']),
                    ),
                  ),
                ),
              ],
            );
          }else if(snapshot.hasError){
            var error = snapshot.error as Map<String,String>;
            return ShowWarning(titile: error['title']!,desc: error['desc']!, onPressed: _refresh,);
          }else{
            return Center(child: CustCircularIndicator(),);
          }
            })
      ),
    );
  }

  Widget roomCard({required String roomNumber, required int totalBeds,required int availableBeds, bool isAc = false}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.ss)),
      color: Colors.white,
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(10.ss),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    FontAwesomeIcons.doorClosed,
                    color: Colors.black,
                    size: 20.ss,
                  ),
                  SizedBox(
                    width: 8.ss,
                  ),
                  Expanded(
                    child: Text(
                      '$roomNumber',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  if (isAc)
                    const Text(
                      'AC',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: CustColor.Blue,
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(height: 10.ss),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8.ss, vertical: 10.ss),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.ss),
                    border: Border.all(color: Colors.black12)),
                child: Row(
                  children: [
                    Icon(FontAwesomeIcons.bed, size: 16, color: Colors.black54),
                    SizedBox(width: 8.ss),
                    Expanded(
                        child: RichText(
                      text: TextSpan(
                          text: ' Total Beds ',
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                              fontWeight: FontWeight.w500),
                          children: [
                            TextSpan(text: ' '),
                            TextSpan(
                                text: '$totalBeds',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black))
                          ]),
                    ))
                  ],
                ),
              ),
            ),
            SizedBox(height: 5.ss),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8.ss, vertical: 10.ss),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.ss),
                    border: Border.all(color: Colors.black12)),
                child: Row(
                  children: [
                    Icon(
                      availableBeds > 0 ? Icons.check : Icons.close,
                      size: 18,
                      color: availableBeds > 0 ? Colors.green[800] : Colors.red,
                    ),
                    SizedBox(width: 5.ss),
                    Expanded(
                        child: RichText(
                      text: TextSpan(
                          text: 'Available',
                          style: TextStyle(
                              fontSize: 14,
                              color: availableBeds > 0
                                  ? CustColor.Green
                                  : Colors.red,
                              fontWeight: FontWeight.w500),
                          children: [
                            TextSpan(text: ' '),
                            TextSpan(
                                text: '$availableBeds',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ))
                          ]),
                    )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<Map<String,dynamic>> _getRooms() async {
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
      Uri uri = Uri.https(Urls.baseUrl, Urls.roomDetailUrl, {'floorId': '${widget.floorId}'});

      final response =  await get(uri,headers: {
        'authorization' : 'Bearer ${Urls.token}',
        'content_type' : 'application/json',
      });

      if(response.statusCode == 200){
        final rawBody = jsonDecode(response.body);
        if(rawBody['status'] == 'Success' && rawBody['rooms']['result']!=null){
          var result = {
            'result' : Map<String,dynamic>.from(rawBody['rooms']['result']),
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
  _refresh(){
    setState(() {});
  }

}
