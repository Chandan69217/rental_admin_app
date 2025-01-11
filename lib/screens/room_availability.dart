import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizing/sizing.dart';

import '../utilities/cust_color.dart';

class RoomAvailability extends StatelessWidget {
  final Map<String, dynamic> details;
  RoomAvailability({required this.details});
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
          Text('${details['floor_name']}',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Colors.white,)),
          titleSpacing: 0,
          leading: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(Icons.keyboard_arrow_left_rounded)),
        ),
        body: Column(
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
                              text: '(${details['total_rooms']})',
                              style: TextStyle(color: CustColor.Green))
                        ]),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.person,
                        color: Colors.black,
                        size: 20,
                      ),
                      SizedBox(
                        width: 3.ss,
                      ),
                      Text(
                        details['name'],
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
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 0,
                  shrinkWrap: true,
                  childAspectRatio: 1,
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
            ),
          ],
        ),
      ),
    );
  }

  Widget roomCard(
      String roomNumber, int totalBeds, int availableBeds, bool isAc) {
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

}
