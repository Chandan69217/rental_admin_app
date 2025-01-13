import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rental_admin_app/screens/attendance_history.dart';
import 'package:rental_admin_app/screens/hostel_floors.dart';
import 'package:rental_admin_app/utilities/cust_color.dart';
import 'package:sizing/sizing.dart';




class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustColor.Background,
      appBar: AppBar(
        backgroundColor: CustColor.Green,
        foregroundColor: Colors.white,
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage('https://placehold.co/40x40'),
              radius: 20.ss,
            ),
            SizedBox(width: 10.ss),
            Text('Chandan Sharma',style:Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white)),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(FontAwesomeIcons.search,size: 20.ss,),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(FontAwesomeIcons.bell,size: 20.ss,),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(20.ss),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ButtonsSection(),
            SizedBox(height: 20.ss),
            Text('Dashboard', style: Theme.of(context).textTheme.bodyLarge),
            SizedBox(height: 10.ss),
            Expanded(
              child: ListView(
                children: [
                  HostelCard(
                    onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HostelFloors(title: 'Hostel 1',subTitle: 'Boys Hostel'))),
                    title: 'Hostel 1',
                    subtitle: 'Boys Hostel',
                    stats: [
                      {'icon': FontAwesomeIcons.layerGroup, 'label': 'Total Floors', 'value': '5'},
                      {'icon': FontAwesomeIcons.doorOpen, 'label': 'Total Rooms', 'value': '50'},
                      {'icon': FontAwesomeIcons.bed, 'label': 'Total Beds', 'value': '200'},
                      {'icon': FontAwesomeIcons.bed, 'label': 'Unoccupied', 'value': '34'},
                    ],
                  ),
                  HostelCard(
                    onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HostelFloors(title: 'Hostel 2',subTitle: 'Boys Hostel'))),
                    title: 'Hostel 2',
                    subtitle: 'Boys Hostel',
                    stats: [
                      {'icon': FontAwesomeIcons.layerGroup, 'label': 'Total Floors', 'value': '4'},
                      {'icon': FontAwesomeIcons.doorOpen, 'label': 'Total Rooms', 'value': '40'},
                      {'icon': FontAwesomeIcons.bed, 'label': 'Total Beds', 'value': '160'},
                      {'icon': FontAwesomeIcons.bed, 'label': 'Unoccupied', 'value': '21'},
                    ],
                  ),
                  HostelCard(
                    onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HostelFloors(title: 'Hostel 3',subTitle: 'Girls Hostel'))),
                    title: 'Hostel 3',
                    subtitle: 'Girls Hostel',
                    stats: [
                      {'icon': FontAwesomeIcons.layerGroup, 'label': 'Total Floors', 'value': '4'},
                      {'icon': FontAwesomeIcons.doorOpen, 'label': 'Total Rooms', 'value': '40'},
                      {'icon': FontAwesomeIcons.bed, 'label': 'Total Beds', 'value': '160'},
                      {'icon': FontAwesomeIcons.bed, 'label': 'Unoccupied', 'value': '21'},
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
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

      children: [
        DashboardButton(label: ' Wardens', icon: FontAwesomeIcons.userShield),
        DashboardButton(label: 'Students', icon: FontAwesomeIcons.userGraduate),
        DashboardButton(label: 'Attendance', icon: FontAwesomeIcons.clipboardList,onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=> AttendanceHistory())),),
        DashboardButton(label: 'Assign Room', icon: FontAwesomeIcons.plusCircle),
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

class HostelCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<Map<String, dynamic>> stats;
  final VoidCallback? onTap;
  HostelCard({required this.title, required this.subtitle, required this.stats,this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 20.ss),
        padding: EdgeInsets.all(15.ss),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.ss),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: Offset(0, 2.ss),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: Theme.of(context).textTheme.bodyMedium),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(color: subtitle == 'Girls Hostel' ? CustColor.Pink : CustColor.Blue),
                ),
              ],
            ),
            SizedBox(height: 10.ss),
            GridView.count(crossAxisCount: 2,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              crossAxisSpacing: 10.ss,
              mainAxisSpacing: 10.ss,
              childAspectRatio: 2.5,
              children: stats.map((stat) {
                return StatCard(
                  icon: stat['icon'],
                  label: stat['label'],
                  value: stat['value'],
                );
              }).toList(),
            )
          ],
        ),
      ),
    );
  }
}

class StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  StatCard({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.ss),
      decoration: BoxDecoration(
        color: CustColor.Light_Green,
        borderRadius: BorderRadius.circular(10.ss),
      ),
      child: Row(
        children: [
          Expanded(flex:1,child: Icon(icon, size: 24.ss, color: CustColor.Green)),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Text(label, style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 14, fontWeight: FontWeight.w500,color: CustColor.Gray))),
                Expanded(child: Text(value, style: Theme.of(context).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.bold))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}