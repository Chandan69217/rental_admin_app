import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 1,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 120,
                      color: Colors.green[800],
                    ),
                    Positioned(
                      top: 40,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage('https://placehold.co/100x100'),
                      ),
                    ),
                    Positioned(
                      top: 80,
                      right: 20,
                      child: Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 60),
                Text(
                  'Kirit Pandey',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Hostel Name',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  '+91 9008007006',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
                SizedBox(height: 20),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    featureButton(Icons.person, 'Wardens'),
                    featureButton(Icons.group, 'Students'),
                    featureButton(Icons.calendar_today, 'Attendance'),
                    featureButton(Icons.meeting_room, 'Assign Room', isAssignRoom: true),
                  ],
                ),
                SizedBox(height: 20),
                Divider(),
                Column(
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Text('Terms & Conditions'),
                      style: TextButton.styleFrom(foregroundColor: Colors.green[800]),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text('Privacy Policy'),
                      style: TextButton.styleFrom(foregroundColor: Colors.green[800]),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text('Contact us'),
                      style: TextButton.styleFrom(foregroundColor: Colors.green[800]),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                logoutButton(),
                SizedBox(height: 10),
                Text(
                  'App Version 1.0.0',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget featureButton(IconData icon, String label, {bool isAssignRoom = false}) {
    return Container(
      width: 150,
      height: 100,
      decoration: BoxDecoration(
        color: isAssignRoom ? Colors.green[50] : Colors.white,
        border: Border.all(
          color: isAssignRoom ? Colors.green[800]! : Colors.grey[300]!,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 30, color: isAssignRoom ? Colors.green[800] : Colors.black54),
          SizedBox(height: 5),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: isAssignRoom ? Colors.green[800] : Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  Widget logoutButton() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        width: 250,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.logout, color: Colors.black54, size: 20),
            SizedBox(width: 5),
            Text(
              'Log Out',
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}
