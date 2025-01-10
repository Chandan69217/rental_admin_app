import 'package:flutter/material.dart';

class RoomAvailability extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green[800],
          title: Text('1st Floor', style: TextStyle(fontSize: 20)),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Total Rooms (10)',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[800],
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Icon(Icons.person, color: Colors.black54),
                  SizedBox(width: 10),
                  Text(
                    'Amit Kumar',
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  children: [
                    roomCard('101', 4, 1, true),
                    roomCard('102', 4, 1, true),
                    roomCard('103', 4, 1, false),
                    roomCard('104', 4, 1, true),
                    roomCard('105', 4, 1, true),
                    roomCard('106', 4, 1, true),
                    roomCard('107', 4, 1, false),
                    roomCard('108', 4, 0, false),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget roomCard(String roomNumber, int totalBeds, int availableBeds, bool isAc) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Room $roomNumber',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (isAc)
                  Text(
                    'AC',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[800],
                    ),
                  ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.bed, size: 18, color: Colors.green[800]),
                SizedBox(width: 5),
                Text('Total Beds: $totalBeds'),
              ],
            ),
            SizedBox(height: 5),
            Row(
              children: [
                Icon(
                  availableBeds > 0 ? Icons.check : Icons.close,
                  size: 18,
                  color: availableBeds > 0 ? Colors.green[800] : Colors.red,
                ),
                SizedBox(width: 5),
                Text(
                  'Available Beds: $availableBeds',
                  style: TextStyle(
                    color: availableBeds > 0 ? Colors.green[800] : Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(RoomAvailability());
}