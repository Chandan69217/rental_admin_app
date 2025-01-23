import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart';
import 'package:rental_admin_app/utilities/cust_color.dart';
import 'package:rental_admin_app/utilities/store_to_cache.dart';
import 'package:rental_admin_app/widgets/cust_circular_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizing/sizing.dart';

import '../models/dashboard_data.dart';
import '../utilities/urls.dart';

class AttendanceHistory extends StatefulWidget {
  @override
  State<AttendanceHistory> createState() => _AttendanceHistoryState();
}

class _AttendanceHistoryState extends State<AttendanceHistory>
    with SingleTickerProviderStateMixin {
  final List<Map<String, String>> attendanceData = [
    {
      'name': 'Ankit Kumar',
      'room': 'Room No. 101 - 1st Floor',
      'hostel': 'Hostel 1',
      'status': 'P',
      'image':
          'https://storage.googleapis.com/a1aa/image/EYuYI5a56hb8FRJU9XZpUMMCQUVkAoMj4KRRpmEIIWvmP3AF.jpg',
    },
    {
      'name': 'Avi Nai',
      'room': 'Room No. 101 - 1st Floor',
      'hostel': 'Hostel 1',
      'status': 'A',
      'image':
          'https://storage.googleapis.com/a1aa/image/gfNOAreeQxT9fQRevoOuCiuf0qkYff7XfTpzPOynOxGM785GoA.jpg',
    },
    {
      'name': 'Ayur Dev',
      'room': 'Room No. 101 - 1st Floor',
      'hostel': 'Hostel 1',
      'status': 'P',
      'image':
          'https://storage.googleapis.com/a1aa/image/KVpuTCfDcvRIBq9krFX4UbdXTsvuJxHH0QMQxJW75EAOfcDUA.jpg',
    },
    {
      'name': 'Basant Kumar',
      'room': 'Room No. 101 - 1st Floor',
      'hostel': 'Hostel 1',
      'status': 'P',
      'image':
          'https://storage.googleapis.com/a1aa/image/GuYwtDgP1AYGH9fgX1Rmgr3QeeH4tfjas0EwDfcXVnefQfcDUA.jpg',
    },
    {
      'name': 'Jannat Kaur',
      'room': 'Room No. 101 - 1st Floor',
      'hostel': 'Hostel 1',
      'status': 'P',
      'image':
          'https://storage.googleapis.com/a1aa/image/fKqLXi714JQ5dymhxCPhourjp6zxXMS7XBJC7y9rc2CSfcDUA.jpg',
    },
    {
      'name': 'Mani Kum',
      'room': 'Room No. 101 - 1st Floor',
      'hostel': 'Hostel 1',
      'status': 'P',
      'image':
          'https://storage.googleapis.com/a1aa/image/CleEOsUnIXziLieguBBIUguujSDVJj3abNBkvsH8jmIie5GoA.jpg',
    },
    {
      'name': 'Seri Sen',
      'room': 'Room No. 101 - 1st Floor',
      'hostel': 'Hostel 1',
      'status': 'P',
      'image':
          'https://storage.googleapis.com/a1aa/image/p2m4cENyfcQrMqfjsQt3rFbFJiSHmIKTudVLipcoJTlf85GoA.jpg',
    },
  ];
  List<Map<String,dynamic>> _hostelNameList = [];
  List<Map<String,dynamic>> _floorNameList = [];
  late TabController _tabController;
  bool isInternetAccess = true;
  int? _hostelSelectedId;
  int? _floorSelectedId;
  int totalPresentTenant = 0;
  int totalTenant = 0 ;
  int totalAbsentTenant = 0;
  List<Map<String,dynamic>> attendanceDetails = [];
  late SharedPreferences pref;


  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener((){setState(() {});});
    _getHostelNameFromAPI();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
   _tabController.removeListener((){});
  }

  Future<List<Map<String, dynamic>>> _getHostelNameFromAPI() async {
    pref = await SharedPreferences.getInstance();

    // Check internet connectivity
    final connectionResult = await Connectivity().checkConnectivity();
    if (!(connectionResult.contains(ConnectivityResult.mobile) ||
        connectionResult.contains(ConnectivityResult.wifi) ||
        connectionResult.contains(ConnectivityResult.ethernet))) {
      setState(() {
        isInternetAccess = false;
      });
      return Future.error({
        'title': 'No connection',
        'desc': 'Please check your internet connectivity and try again',
      });
    }

    // Check if the token is null
    if (DashboardData.token == null) {
      return Future.error({
        'title': 'Something went wrong !!',
        'desc': 'Please restart the app and try again.',
      });
    }

    try {
      final token = DashboardData.token ?? '';
      Uri hostelNameListUri = Uri.https(Urls.baseUrl, Urls.getHostelNameListUrl);

      // API call to get hostel names
      final hostelNameListResponse = await get(
        hostelNameListUri,
        headers: {
          'authorization': 'Bearer ${Urls.token}',
          'content_type': 'application/json',
        },
      );

      // Check the response status
      if (hostelNameListResponse.statusCode == 200) {
        var rawData = jsonDecode(hostelNameListResponse.body) as List<dynamic>;
        return List<Map<String, dynamic>>.from(
          rawData.map((e) => Map<String, dynamic>.from(e)),
        );
      } else if (hostelNameListResponse.statusCode >= 400 && hostelNameListResponse.statusCode < 500) {
        print('Client Error: Unable to fetch Hostel Name List (Status Code: ${hostelNameListResponse.statusCode})');
        return Future.error({
          'title': 'Client Error',
          'desc': 'There seems to be an issue with the request. Please try again.',
        });
      } else if (hostelNameListResponse.statusCode >= 500 && hostelNameListResponse.statusCode < 600) {
        print('Server Error: Unable to fetch Hostel Name List (Status Code: ${hostelNameListResponse.statusCode})');
        return Future.error({
          'title': 'Server Error',
          'desc': 'The server encountered an error. Please try again later.',
        });
      } else {
        print('Unexpected Error: Unable to fetch Hostel Name List');
        return Future.error({
          'title': 'Unexpected Error',
          'desc': 'Please retry after some time.',
        });
      }
    } catch (exception) {
      print('Exception: $exception');
      return Future.error({
        'title': 'Something went wrong !!',
        'desc': 'Please retry after sometime',
      });
    }
  }


  void _getAttendanceList({required int floorId, required int hostelId}) async {
    pref = await SharedPreferences.getInstance();

    final connectionResult = await Connectivity().checkConnectivity();
    if (!(connectionResult.contains(ConnectivityResult.mobile) ||
        connectionResult.contains(ConnectivityResult.wifi) ||
        connectionResult.contains(ConnectivityResult.ethernet))) {
      setState(() {
        isInternetAccess = false;
      });
      return Future.error({
        'title': 'No connection',
        'desc': 'Please check your internet connectivity and try again.',
      });
    }

    if (DashboardData.token == null) {
      return Future.error({
        'title': 'Authentication Failed',
        'desc': 'Please restart the app and try again. Token is missing.',
      });
    }

    try {
      final token = DashboardData.token ?? '';
      Uri attendanceListUri = Uri.https(Urls.baseUrl, Urls.getAttendanceListUrl, {
        'hostelId': '$hostelId',
        'floorId': '$floorId',
      });

      final attendanceListResponse = await post(
        attendanceListUri,
        headers: {
          'Authorization': 'Bearer ${Urls.token}',
          'Content-Type': 'application/json',
        },
      );

      if (attendanceListResponse.statusCode == 200) {
        var rawData = jsonDecode(attendanceListResponse.body) as Map<String, dynamic>;

        totalTenant = rawData['totalTenant'];
        totalPresentTenant = rawData['totalPresent'];
        totalAbsentTenant = rawData['totalAbsent'];

        var tenantDetails = rawData['tenantDetails'] as List<dynamic>;
        attendanceDetails = tenantDetails.map((item) {
          return item as Map<String, dynamic>;
        }).toList();

        setState(() {});

      } else if (attendanceListResponse.statusCode >= 400 && attendanceListResponse.statusCode < 500) {
        print('Client Error: ${attendanceListResponse.statusCode}');
        return Future.error({
          'title': 'Client Error',
          'desc': 'There was an issue with your request. Please try again later.',
        });

      } else if (attendanceListResponse.statusCode >= 500 && attendanceListResponse.statusCode < 600) {
        print('Server Error: ${attendanceListResponse.statusCode}');
        return Future.error({
          'title': 'Server Error',
          'desc': 'There was an issue on the server. Please try again later.',
        });

      } else {
        print('Unexpected Error: ${attendanceListResponse.statusCode}');
        return Future.error({
          'title': 'Unexpected Error',
          'desc': 'An unexpected error occurred. Please try again later.',
        });
      }

    } catch (exception) {
      print('Exception occurred: $exception');
      return Future.error({
        'title': 'Something went wrong !!',
        'desc': 'Please retry after sometime. If the issue persists, contact support.',
      });
    }
  }


  List<Map<String, dynamic>> sortAttendanceList(List<Map<String, dynamic>> attendanceList, String status) {
    if (status != 'Present' && status != 'Absent') {
      throw ArgumentError('Invalid sort status. Must be "Present" or "Absent".');
    }
    return attendanceList.where((tenant) => tenant['tenantAttendanceStatus'] == status).toList();
  }

  void _getFloorNameFromAPI(int hostelId) async {
    pref = await SharedPreferences.getInstance();

    final connectionResult = await Connectivity().checkConnectivity();
    if (!(connectionResult.contains(ConnectivityResult.mobile) ||
        connectionResult.contains(ConnectivityResult.wifi) ||
        connectionResult.contains(ConnectivityResult.ethernet))) {
      setState(() {
        isInternetAccess = false;
      });
      return Future.error({
        'title': 'No connection',
        'desc': 'Please check your internet connectivity and try again.',
      });
    }

    if (DashboardData.token == null) {
      return Future.error({
        'title': 'Authentication Failed',
        'desc': 'Please restart the app and try again. Token is missing.',
      });
    }

    try {
      final token = DashboardData.token ?? '';

      Uri floorNameListUri = Uri.https(Urls.baseUrl, Urls.getHostelFloorListUrl, {'hostelId': '$hostelId'});

      final floorNameListResponse = await get(floorNameListUri, headers: {
        'Authorization': 'Bearer ${Urls.token}',
        'Content-Type': 'application/json',
      });

      if (floorNameListResponse.statusCode == 200) {
        var rawData = jsonDecode(floorNameListResponse.body) as List<dynamic>;

        _floorNameList = List<Map<String, dynamic>>.from(
            rawData.map((e) => Map<String, dynamic>.from(e))
        );

        setState(() {});

      } else if (floorNameListResponse.statusCode >= 400 && floorNameListResponse.statusCode < 500) {
        print('Client Error: ${floorNameListResponse.statusCode}');
        return Future.error({
          'title': 'Client Error',
          'desc': 'There was an issue with your request. Please try again later.',
        });

      } else if (floorNameListResponse.statusCode >= 500 && floorNameListResponse.statusCode < 600) {
        print('Server Error: ${floorNameListResponse.statusCode}');
        return Future.error({
          'title': 'Server Error',
          'desc': 'There was an issue on the server. Please try again later.',
        });

      } else {
        print('Unexpected Error: ${floorNameListResponse.statusCode}');
        return Future.error({
          'title': 'Unexpected Error',
          'desc': 'An unexpected error occurred. Please try again later.',
        });
      }

    } catch (exception) {
      print('Exception occurred: $exception');
      return Future.error({
        'title': 'Something went wrong !!',
        'desc': 'Please retry after sometime. If the issue persists, contact support.',
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustColor.Background,
      body: FutureBuilder( future: _getHostelNameFromAPI(),
        builder: (context,snapshot){
          return  snapshot.hasData? Column(
            children: [
              // Filter bar
              Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 20.ss, vertical: 10.ss),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                          height: 45.ss,
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.ss,
                          ),
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: CustColor.Background,
                              borderRadius: BorderRadius.circular(6.ss)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                FontAwesomeIcons.hotel, // Replace with your desired icon
                                color: Colors.black,
                                size: 18.ss,
                              ),
                              SizedBox(width: 10.ss),
                              DropdownButtonHideUnderline(
                                child: Expanded(
                                  child: DropdownButton<int>(
                                      icon: Icon(
                                        Icons.keyboard_arrow_down_rounded,
                                        size: 18.ss,
                                      ),
                                      hint: Text('Select hostel'),
                                      iconEnabledColor: Colors.black,
                                      // menuWidth: 80.ss,
                                      dropdownColor: CustColor.Background,
                                      isExpanded: true,
                                      borderRadius: BorderRadius.circular(6.ss),
                                      value: _hostelSelectedId,
                                      style: TextStyle(fontSize: 14,color: Colors.black,overflow: TextOverflow.ellipsis,),
                                      items:snapshot.data!.map((value) {
                                        return DropdownMenuItem<int>(
                                          value: value['id'],
                                          child: Text(value['hostelName'] ?? 'Unknown Hostel'),
                                        );
                                      }).toList(),
                                      onChanged: (value) async{
                                        _hostelSelectedId = value!;
                                        if(_hostelSelectedId!=null){
                                          _getFloorNameFromAPI(_hostelSelectedId!);
                                        }
                                        setState((){});
                                      }),
                                ),
                              ),
                            ],
                          )),
                    ),
                    SizedBox(width: 10.ss),
                    Expanded(
                      child: Container(
                          height: 45.ss,
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.ss,
                          ),
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: CustColor.Background,
                              borderRadius: BorderRadius.circular(6.ss)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                FontAwesomeIcons.layerGroup, // Replace with your desired icon
                                color: Colors.black,
                                size: 18.ss,
                              ),
                              SizedBox(width: 10.ss),
                              DropdownButtonHideUnderline(
                                child: Expanded(
                                  child: DropdownButton<int>(
                                      icon: Icon(
                                        Icons.keyboard_arrow_down_rounded,
                                        size: 18.ss,
                                      ),
                                      hint: Text('Select floor'),
                                      iconEnabledColor: Colors.black,
                                      // menuWidth: 80.ss,
                                      dropdownColor: CustColor.Background,
                                      isExpanded: true,
                                      borderRadius: BorderRadius.circular(6.ss),
                                      value: _floorSelectedId,
                                      style: TextStyle(fontSize: 14,color: Colors.black,overflow: TextOverflow.ellipsis,),
                                      items: _floorNameList.map((value) {
                                        return DropdownMenuItem<int>(
                                          value: value['id'],
                                          child: Text(value['floorName'] ?? 'Unknown Hostel'),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          _floorSelectedId = value!;
                                          if(_floorSelectedId!=null){
                                            _getAttendanceList(floorId: _floorSelectedId!, hostelId: _hostelSelectedId!);
                                          }
                                        });
                                      }),
                                ),
                              ),
                            ],
                          )),
                    ),
                  ],
                ),
              ),

              // Tab
              Container(
                  height: kTextTabBarHeight*0.67,
                  padding: EdgeInsets.symmetric(horizontal: 10.ss),
                  child: TabBar(
                    controller: _tabController,
                    overlayColor: const WidgetStatePropertyAll(Colors.transparent),
                    indicatorSize: TabBarIndicatorSize.tab,
                    unselectedLabelColor: CustColor.Green,
                    labelColor: Colors.white,
                    indicator: BoxDecoration(
                      color: CustColor.Green,
                      borderRadius: BorderRadius.circular(6.ss),
                    ),
                    tabs: <Tab>[
                      Tab(child: Text('All(${totalTenant})',style: TextStyle(color: _tabController.index == 0 ? Colors.white:Colors.black))),
                      Tab(
                        child: Text(
                          'Present(${totalPresentTenant})',
                        ),
                      ),
                      Tab(
                        child: Text(
                          'Absent($totalAbsentTenant)',style: TextStyle(color: _tabController.index == 2 ? Colors.white:CustColor.Red),
                        ),
                      )
                    ],
                  )),
              // Attendance List
              Expanded(
                child: TabBarView(
                    controller: _tabController,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      _AttendanceList(attendanceData: attendanceDetails),
                      _AttendanceList(attendanceData: sortAttendanceList(attendanceDetails, 'Present')),
                      _AttendanceList(attendanceData: sortAttendanceList(attendanceDetails, 'Absent')),
                    ]),
              )
            ],
          ):Center(child: CustCircularIndicator(),);
        }
      ),
    );
  }
}


class _AttendanceList extends StatefulWidget{
  final List<Map<String, dynamic>> attendanceData;
  _AttendanceList({required this.attendanceData});
  @override
  State<_AttendanceList> createState() => _AttendanceListState();
}

class _AttendanceListState extends State<_AttendanceList> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    return widget.attendanceData.isEmpty ? Center(child: Text('No Data'),):ListView.builder(
      padding: const EdgeInsets.all(10),
      shrinkWrap: true,
      itemCount: widget.attendanceData.length,
      itemBuilder: (context, index) {
        final data = widget.attendanceData[index];
        final isPresent = data['tenantAttendanceStatus'] == 'Present';
        return Card(
          margin: const EdgeInsets.only(bottom: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
            leading: CircleAvatar(
             // backgroundImage: NetworkImage(data['image']!),
            ),
            title: Text(
              data['tenantName']!,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            subtitle: Text(
              'Room No. ${data['tenantRoomNumber']} - ${data['tenantFloorName']}\n${data['tenantHostelName']}',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: CustColor.Gray),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 5),
                  decoration: BoxDecoration(
                    color: isPresent
                        ? const Color(0xFFE8F5E9)
                        : const Color(0xFFFFEBEE),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    isPresent ? 'Present' : 'Absent',
                    style: TextStyle(
                      color: isPresent
                          ? const Color(0xFF2E7D32)
                          : const Color(0xFFD32F2F),
                    ),
                  ),
                ),
                const SizedBox(width: 5),
        // IconButton(
        //   onPressed: () {},
        //   icon: const Icon(Icons.more_vert),
        // ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}