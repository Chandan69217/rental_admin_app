import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rental_admin_app/widgets/cust_textfield.dart';
import '../models/dashboard_data.dart';
import '../utilities/cust_color.dart';
import '../widgets/cust_circular_indicator.dart';
import 'dashboard.dart';
import 'home_screen.dart';
import 'hostel_floors.dart';

class AssignRoom extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _AssignRoomStates();
}

class _AssignRoomStates extends State<AssignRoom> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustColor.Background,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Occupied rooms(89)',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(color: CustColor.Gray),
                    ),
                    SizedBox(width: 8.0),
                    Container(
                      constraints: BoxConstraints(minHeight: 20, minWidth: 20),
                      color: Colors.red,
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Unoccupied rooms(23)',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(color: CustColor.Gray),
                    ),
                    SizedBox(width: 8.0),
                    Container(
                      constraints: BoxConstraints(minHeight: 20, minWidth: 20),
                      color: CustColor.Green,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                return _roomList(onSelection: _showAssignRoomDialog,);
              },
              ),
            )
          ],
        ),
      ),
    );
  }

  _showAssignRoomDialog(String Room_No){
    TextEditingController roomNoController = TextEditingController();
    roomNoController.text = Room_No;
    String? dropdownvalue;
    List<String> items = ['Cash', 'Credit Card', 'PayPal', 'Bank Transfer'];
    showDialog(context: context, builder: (context){
      return AlertDialog(
        // title:  SizedBox(
        //   child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children:
        //   [
        //     Expanded(child: RichText(text: TextSpan(text: 'Admin Id: ',children: [TextSpan(text: '12322',)],style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: CustColor.Gray)))),
        //     Expanded(child: RichText(text: TextSpan(text: 'Hostel Id: ',children: [TextSpan(text: '12322',)],style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: CustColor.Gray)))),
        //   ],),
        // ),
        title: Text('details'),
        content: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Tenant Id'),
                          SizedBox(height: 5,),
                          CustTextField(
                            prefixIcon: Icon(FontAwesomeIcons.idCard,color: Colors.black,),
                          )
                        ],
                      ),
                    ),
                      SizedBox(width: 20,),
                      Expanded(
                        child: Column(
                          children: [
                            const Text(''),
                            SizedBox(height: 5,),
                            Container(
                            padding: EdgeInsets.symmetric(horizontal:10,vertical: 2), // Adds some padding inside
                            decoration: BoxDecoration(
                              border: Border.all(width: 1), // Outline border color and width
                              borderRadius: BorderRadius.circular(5.0), // Rounded corners
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                elevation: 0,
                                value: dropdownvalue,
                                hint: Text('Payment Mode'),
                                icon: Icon(Icons.keyboard_arrow_down),
                                isExpanded: true,
                                borderRadius: BorderRadius.circular(5.0),
                                items:items.map((String items) {
                                  return DropdownMenuItem(
                                      value: items,
                                      child: Text(items)
                                  );
                                }
                                ).toList(),

                                onChanged: (String? newValue){
                                  setState(() {
                                    dropdownvalue = newValue!;
                                  });
                                },

                              ),
                            ),
                          ),
                          ]
                        ),
                      ),
                    ]
                  ),
                ),
                SizedBox(
                  height:10,
                ),
                
                // Room Number & Rent Row
                SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Room Number'),
                            SizedBox(height: 5,),
                            CustTextField(
                              prefixIcon: Icon(FontAwesomeIcons.doorClosed,color: Colors.black,),
                              controller: roomNoController,
                              enable: false,
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Rent'),
                            SizedBox(height: 5,),
                            CustTextField(
                              textInputType: TextInputType.number,
                              prefixIcon: Icon(FontAwesomeIcons.indianRupeeSign,color: Colors.black,),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Duration'),
                      SizedBox(height: 5,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  showDatePicker(
                                    context: context,
                                    initialEntryMode: DatePickerEntryMode.calendarOnly,
                                    selectableDayPredicate: (selectedDate){
                                      return true;
                                    },
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime.now(),
                                  ).then((pickedDate){
                                    if(pickedDate !=null){
                                      setState(() {
                                        // _startDateEnding = pickedDate.add(Duration(days: 1));
                                        // if(_leaveData.containsKey('startDate')){
                                        //   _leaveData.update('startDate', (_)=>_dateFormat.format(pickedDate));
                                        //   _leaveData.remove('endDate');
                                        // }else{
                                        //   _leaveData.putIfAbsent('startDate', ()=>_dateFormat.format(pickedDate));
                                        //
                                        // }
                                      });
                                    }
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    border: Border.all(),
                                    borderRadius: BorderRadius.circular(4),
                                    // boxShadow: [BoxShadow(color: ColorTheme.Gray,blurRadius: 4.ss)]
                                  ),
                                  child:  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                          child: Text( 'start date',
                                           // _leaveData.containsKey('startDate') ? _leaveData['startDate']! :'start date',
                                            textAlign: TextAlign.center,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.normal),
                                          )),
                                      const Icon(
                                        Icons.calendar_month_outlined,
                                      )
                                    ],
                                  ),
                                ),
                              )
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                              child: GestureDetector(
                                // onTap: _leaveData.containsKey('startDate')?() {
                                //   showDatePicker(
                                //     context: context,
                                //     initialEntryMode: DatePickerEntryMode.calendarOnly,
                                //     currentDate: DateTime.now(),
                                //     firstDate: _startDateEnding,
                                //     lastDate: _lastDate,
                                //   ).then((pickedDate){
                                //     if(pickedDate !=null){
                                //       setState(() {
                                //         _leaveData.putIfAbsent('endDate', ()=>_dateFormat.format(pickedDate));
                                //       });
                                //     }
                                //   });
                                // }:()=> Fluttertoast.showToast(msg: 'first select starting date then ending'),
                                child: Container(
                                  padding: EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    // color: ColorTheme.LIGHT_RED,
                                    // boxShadow: [BoxShadow(color: ColorTheme.Gray,blurRadius: 4.ss)],
                                    borderRadius:
                                    BorderRadius.circular(4),
                                    border: Border.all(),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                          child: Text('end date',
                                            // _leaveData.containsKey('endDate')?_leaveData['endDate']!:'end date',
                                            textAlign: TextAlign.center,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontWeight: FontWeight.normal),
                                          )),
                                      Icon(
                                        Icons.calendar_month_outlined,
                                        // color: ColorTheme.RED_DEEP1,
                                      )
                                    ],
                                  ),
                                ),
                              )
                          ),
                        ],
                      ),
                    ],
                  ),),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Remarks (in 150 characters)'),
                    SizedBox(
                      height: 5,
                    ),
                    TextField(
                      maxLines: 3,
                      maxLength: 150,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                          hintText: "Type cause....",
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4)),
                          border: InputBorder.none,
                          hintStyle: TextStyle(fontSize: 14,color: CustColor.Gray)),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: false ? const Center(child: CircularProgressIndicator(color: Colors.white,)): ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: const WidgetStatePropertyAll(CustColor.Blue),
                          foregroundColor: const WidgetStatePropertyAll(Colors.white),
                          shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))
                      ),
                      onPressed: () {  },
                      child: Text('Assign',style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white),),
                ),)
              ],
            ),
          ),
        ),
      );
    });
  }
}

class _roomList extends StatelessWidget{
  final Function(String) onSelection;
  _roomList({required this.onSelection});
  
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Chhoti Niwash'),
        // Horizontal ListView.builder for floors
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 300,
          child: PageView.builder(
            itemCount: 4,
              itemBuilder: (context,index){
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Floor ${index + 1}'), // Display floor number
                      SizedBox(height: 5),
                      // GridView for rooms on this floor
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: 20, // Number of rooms
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 5,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                              childAspectRatio: 2
                          ),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: ()=>onSelection('102'),
                              child: Container(
                                padding: const EdgeInsets.all(2.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  color: Colors.red,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // Text(
                                    //   'Room No',
                                    //   style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 11),
                                    // ),
                                    Text(
                                      '102',
                                      style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.white),
                                    ),
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
              }),
        ),
      ],
    );
  }

}

// class _roomList extends StatelessWidget{
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text('Chhoti Niwash'),
//         // Horizontal ListView.builder for floors
//         SizedBox(
//           width: MediaQuery.of(context).size.width,
//           height: 250,
//           child: ListView.builder(
//             itemCount: 5,
//             shrinkWrap: true,
//             scrollDirection: Axis.horizontal,
//             itemBuilder: (BuildContext context, int index) {
//               return Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text('Floor ${index + 1}'), // Display floor number
//                       SizedBox(height: 5),
//                       // GridView for rooms on this floor
//                       SizedBox(
//                         width: MediaQuery.of(context).size.width,
//                         child: GridView.builder(
//                           physics: NeverScrollableScrollPhysics(),
//                           itemCount: 20, // Number of rooms
//                           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                             crossAxisCount: 5,
//                             mainAxisSpacing: 10,
//                             crossAxisSpacing: 10,
//                             childAspectRatio: 2
//                           ),
//                           shrinkWrap: true,
//                           itemBuilder: (context, index) {
//                             return Container(
//                               padding: const EdgeInsets.all(2.0),
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(8.0),
//                                 color: Colors.red,
//                               ),
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   // Text(
//                                   //   'Room No',
//                                   //   style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 11),
//                                   // ),
//                                   Text(
//                                     '102',
//                                     style: Theme.of(context).textTheme.bodyLarge,
//                                   ),
//                                 ],
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//             },
//           ),
//         ),
//       ],
//     );
//   }
//
// }


class _hostelSelection extends  StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustColor.Background,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: FutureBuilder(
          future: Future.value(1),
          builder: (context,snapshot)=>Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: CustColor.Gray),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(FontAwesomeIcons.search,color: CustColor.Green,),
                    border: InputBorder.none,
                    hintText: 'Search hostel',
                    hintStyle: TextStyle(color: CustColor.Gray)
                  ),
                ),
              ),
              SizedBox(height: 12.0,),
              Expanded(
                child: !snapshot.hasData ? Center(child: CustCircularIndicator(),):
                ListView.builder(itemCount: DashboardData.hostels != null ? DashboardData.hostels!.length:0,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (context,index){
                      return HostelCard(
                        onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HostelFloors(title: DashboardData.hostels![index]['hostelName'],subTitle: DashboardData.hostels![index]['hostelType'],hostel_id: DashboardData.hostels![index]['id']??0,))),
                        title: DashboardData.hostels![index]['hostelName'],
                        subtitle: DashboardData.hostels![index]['hostelType'],
                        stats: [
                          {'icon': FontAwesomeIcons.layerGroup, 'label': 'Total Floors', 'value': '${DashboardData.hostels![index]['totalFloor']}'},
                          {'icon': FontAwesomeIcons.doorOpen, 'label': 'Total Rooms', 'value': '${DashboardData.hostels![index]['totalRoom']}'},
                          {'icon': FontAwesomeIcons.bed, 'label': 'Total Beds', 'value': '${DashboardData.hostels![index]['totalBed']}'},
                          {'icon': FontAwesomeIcons.bed, 'label': 'Unoccupied', 'value': 'N/A'},
                        ],
                      );
                    }
                ),
                // ListView(
                //   children: [
                //     HostelCard(
                //       onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HostelFloors(title: 'Hostel 1',subTitle: 'Boys Hostel'))),
                //       title: 'Hostel 1',
                //       subtitle: 'Boys Hostel',
                //       stats: [
                //         {'icon': FontAwesomeIcons.layerGroup, 'label': 'Total Floors', 'value': '5'},
                //         {'icon': FontAwesomeIcons.doorOpen, 'label': 'Total Rooms', 'value': '50'},
                //         {'icon': FontAwesomeIcons.bed, 'label': 'Total Beds', 'value': '200'},
                //         {'icon': FontAwesomeIcons.bed, 'label': 'Unoccupied', 'value': '34'},
                //       ],
                //     ),
                //     HostelCard(
                //       onTap: ()=> Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HostelFloors(title: 'Hostel 2',subTitle: 'Boys Hostel'))),
                //       title: 'Hostel 2',
                //       subtitle: 'Boys Hostel',
                //       stats: [
                //         {'icon': FontAwesomeIcons.layerGroup, 'label': 'Total Floors', 'value': '4'},
                //         {'icon': FontAwesomeIcons.doorOpen, 'label': 'Total Rooms', 'value': '40'},
                //         {'icon': FontAwesomeIcons.bed, 'label': 'Total Beds', 'value': '160'},
                //         {'icon': FontAwesomeIcons.bed, 'label': 'Unoccupied', 'value': '21'},
                //       ],
                //     ),
                //     HostelCard(
                //       onTap: ()=> Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HostelFloors(title: 'Hostel 3',subTitle: 'Girls Hostel'))),
                //       title: 'Hostel 3',
                //       subtitle: 'Girls Hostel',
                //       stats: [
                //         {'icon': FontAwesomeIcons.layerGroup, 'label': 'Total Floors', 'value': '4'},
                //         {'icon': FontAwesomeIcons.doorOpen, 'label': 'Total Rooms', 'value': '40'},
                //         {'icon': FontAwesomeIcons.bed, 'label': 'Total Beds', 'value': '160'},
                //         {'icon': FontAwesomeIcons.bed, 'label': 'Unoccupied', 'value': '21'},
                //       ],
                //     ),
                //   ],
                // ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}