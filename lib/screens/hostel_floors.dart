import 'package:flutter/material.dart';

class HostelFloors extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Hostel 1', style: TextStyle(fontSize: 24)),
              Text('Boys Hostel', style: TextStyle(fontSize: 14)),
            ],
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            children: [
              floorCard('1st Floor', 'Amit Kumar', 10, 30, 10),
              floorCard('2nd Floor', 'Ramu Tomar', 10, 32, 8),
              floorCard('3rd Floor', 'Naresh Naidu', 10, 30, 10),
              floorCard('4th Floor', 'Punit Reddy', 10, 22, 18),
              floorCard('5th Floor', 'Manu Reddy', 9, 24, 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget floorCard(String floor, String name, int rooms, int beds, int keys) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: Colors.teal[50],
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              floor,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            Text(
              name,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                detailIcon(Icons.door_front_door, rooms.toString()),
                detailIcon(Icons.bed, beds.toString()),
                detailIcon(Icons.vpn_key, keys.toString()),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget detailIcon(IconData icon, String value) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.green),
        SizedBox(width: 5),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}

void main() {
  runApp(HostelFloors());
}