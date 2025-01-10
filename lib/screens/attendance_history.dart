import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rental_admin_app/utilities/cust_color.dart';
import 'package:sizing/sizing.dart';

class AttendanceHistory extends StatelessWidget {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustColor.Background,
      appBar: AppBar(
        backgroundColor: CustColor.Primary,
        foregroundColor: Colors.white,
        leading: const Icon(Icons.arrow_back_ios_new_rounded),
        title: Text(
          'Attendance History',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white),
        ),
        actions: [
          DropdownButton<String>(
            underline: const SizedBox(),
            value: 'Student',
            onChanged: (value) {},
            items: const [
              DropdownMenuItem(
                value: 'Student',
                child: Text(
                  'Student',
                  style: TextStyle(color: Color(0xFF2E7D32)),
                ),
              ),
            ],
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
                    padding: EdgeInsets.symmetric(horizontal: 20.ss,),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: CustColor.Background,
                      borderRadius: BorderRadius.circular(6.ss)
                    ),
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
                    padding: EdgeInsets.symmetric(vertical: 12.ss),
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: CustColor.Background,
                        borderRadius: BorderRadius.circular(6.ss)
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding:EdgeInsets.only(left: 8.ss,right: 4.ss),
                          child: Icon(Icons.calendar_month,size: 23,color: CustColor.Primary,),
                        ),
                        Expanded(flex:2,child: Text('Current Day',style: Theme.of(context).textTheme.bodySmall,))
                      ],
                    )
                  ),
                ),
              ],
            ),
          ),
          // Tabs
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2E7D32),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text('All (50)'),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE0E0E0),
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text('Present (45)'),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE0E0E0),
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text('Absent (05)'),
                ),
              ],
            ),
          ),
          // Attendance List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: attendanceData.length,
              itemBuilder: (context, index) {
                final data = attendanceData[index];
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
                    subtitle: Text('${data['room']}\n${data['hostel']}',style: Theme.of(context).textTheme.bodySmall!.copyWith(color: CustColor.Gray),),
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
            ),
          ),
        ],
      ),
    );
  }
}