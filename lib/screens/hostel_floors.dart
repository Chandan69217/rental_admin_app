import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rental_admin_app/screens/room_availability.dart';
import 'package:rental_admin_app/utilities/cust_color.dart';
import 'package:sizing/sizing.dart';

class HostelFloors extends StatelessWidget {
  final String title;
  final String subTitle;
  HostelFloors({required this.title,required this.subTitle});
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
              Text(title, style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white)),
              Text(subTitle, style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.white)),
            ],
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(20.ss),
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 4,
            mainAxisSpacing: 4,
            childAspectRatio: 1.6,
            children: [
              floorCard('1st Floor', 'Amit Kumar', 10, 30, 10,onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>RoomAvailability(details: {'floor_name':'1st Floor','name':'Amit Kumar','total_rooms':10},)))),
              floorCard('2nd Floor', 'Ramu Tomar', 10, 32, 8,onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>RoomAvailability(details: {'floor_name':'2nd Floor','name':'Ramu Tomar','total_rooms':10},)))),
              floorCard('3rd Floor', 'Naresh Naidu', 10, 30, 10,onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>RoomAvailability(details: {'floor_name':'3rd Floor','name':'Naresh Naidu','total_rooms':10},)))),
              floorCard('4th Floor', 'Punit Reddy', 10, 22, 18,onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>RoomAvailability(details: {'floor_name':'4th Floor','name':'Punit Reddy','total_rooms':10},)))),
              floorCard('5th Floor', 'Manu Reddy', 9, 24, 16,onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>RoomAvailability(details: {'floor_name':'5th Floor','name':'Manu Reddy','total_rooms':10},)))),
            ],
          ),
        ),
      ),
    );
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
                    const Icon(Icons.person, color: CustColor.Green, size: 18),
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
