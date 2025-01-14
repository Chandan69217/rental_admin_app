import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rental_admin_app/utilities/cust_color.dart';
import 'package:sizing/sizing.dart';

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
  String _attendanceOf = 'Student';
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener((){setState(() {});});
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
   _tabController.removeListener((){});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustColor.Background,
      appBar: AppBar(
        backgroundColor: CustColor.Green,
        foregroundColor: Colors.white,
        titleSpacing: 0.ss,
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.keyboard_arrow_left_rounded)),
        title: Text(
          'Attendance History',
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: Colors.white),
        ),
        actions: [
          Container(
              height: 28.ss,
              padding: EdgeInsets.symmetric(
                horizontal: 4.ss,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.ss),
                border:
                    Border.all(width: 1, color: Colors.white.withOpacity(1)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.person, // Replace with your desired icon
                    color: Colors.white,
                    size: 18.ss,
                  ),
                  SizedBox(width: 4.ss),
                  DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                        icon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          size: 18.ss,
                        ),
                        iconEnabledColor: Colors.white,
                        menuWidth: 80.ss,
                        dropdownColor: CustColor.Green,
                        borderRadius: BorderRadius.circular(6.ss),
                        value: _attendanceOf,
                        items: [
                          DropdownMenuItem<String>(
                            value: 'Student',
                            child: Text(
                              'Student',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      fontSize: 11.fss, color: Colors.white),
                            ),
                          ),
                          DropdownMenuItem<String>(
                            value: 'Wardens',
                            child: Text(
                              'Wardens',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      fontSize: 11.fss, color: Colors.white),
                            ),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _attendanceOf = value!;
                          });
                        }),
                  ),
                ],
              )),
          SizedBox(
            width: 18.ss,
          ),
        ],
      ),
      body: Column(
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
                    child: DropdownButton<String>(
                      elevation: 2,
                      value: 'Floor 1',
                      isExpanded: true,
                      underline: Container(),
                      borderRadius: BorderRadius.circular(6.ss),
                      dropdownColor: CustColor.Background,
                      icon: const Icon(Icons.keyboard_arrow_down_rounded),
                      onChanged: (value) {},
                      items: const [
                        DropdownMenuItem(
                          value: 'Floor 1',
                          child: Text('Floor 1'),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 10.ss),
                Expanded(
                  child: Container(
                      height: 45.ss,
                      padding: EdgeInsets.symmetric(vertical: 12.ss),
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: CustColor.Background,
                          borderRadius: BorderRadius.circular(6.ss)),
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 8.ss, right: 4.ss),
                            child: Icon(
                              Icons.calendar_month,
                              size: 23,
                              color: CustColor.Green,
                            ),
                          ),
                          Expanded(
                              flex: 2,
                              child: Text(
                                'Current Day',
                                style: Theme.of(context).textTheme.bodySmall,
                              ))
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
                  Tab(child: Text('All(50)',style: TextStyle(color: _tabController.index == 0 ? Colors.white:Colors.black))),
                  Tab(
                    child: Text(
                      'Present(45)',
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Absent(05)',style: TextStyle(color: _tabController.index == 2 ? Colors.white:CustColor.Red),
                    ),
                  )
                ],
              )),
          // Attendance List
          Expanded(
            child: TabBarView(
              controller: _tabController,
                children: [
              _AttendanceList(attendanceData: attendanceData),
              _AttendanceList(attendanceData: attendanceData),
              _AttendanceList(attendanceData: attendanceData),
            ]),
          )
        ],
      ),
    );
  }
}


class _AttendanceList extends StatefulWidget{
  final List<Map<String, String>> attendanceData;
  _AttendanceList({required this.attendanceData});
  @override
  State<_AttendanceList> createState() => _AttendanceListState();
}

class _AttendanceListState extends State<_AttendanceList> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(10),
      shrinkWrap: true,
      itemCount: widget.attendanceData.length,
      itemBuilder: (context, index) {
        final data = widget.attendanceData[index];
        final isPresent = data['status'] == 'P';
        return Card(
          margin: const EdgeInsets.only(bottom: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(data['image']!),
            ),
            title: Text(
              data['name']!,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            subtitle: Text(
              '${data['room']}\n${data['hostel']}',
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