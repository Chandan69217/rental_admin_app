import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:rental_admin_app/widgets/cust_textfield.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/dashboard_data.dart';
import '../utilities/consts.dart';
import '../utilities/cust_color.dart';
import '../utilities/urls.dart';
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

  _assignRoom(Map<String,dynamic> data)async{
    final connectivityResult = await Connectivity().checkConnectivity();
    if(!(connectivityResult.contains(ConnectivityResult.mobile)||connectivityResult.contains(ConnectivityResult.wifi)||connectivityResult.contains(ConnectivityResult.ethernet))){
      Fluttertoast.showToast(msg: 'No internet connection');
      return;
    }
    var pref = await SharedPreferences.getInstance();
    final token = pref.getString(Consts.Token)??'';
    final adminId = await pref.getString(Consts.Admin_User_Id);
    try {
      var uri = Uri.https(Urls.baseUrl, Urls.assignRoomUrl);
      var body = json.encode({
          "hostelAdminId": int.parse(adminId!),
          "tenantId": int.parse(data['tenantId']),
          "hostelId": 0,
          "monthlyRent": int.parse(data['monthlyRent']),
          "roomNumber": data['roomNumber'],
          "startDate": data['startDate'],
          "endDate": data['endDate'],
          "paymentMode": data['paymentMode'],
          "remarks": data['remarks']
        });

      var response = await post(uri, body: body, headers: {
        'authorization':'bearer ${Urls.token}',
        'Content-Type': 'application/json',
      });
      Navigator.of(context).pop();
      if (response.statusCode == 200) {
        AwesomeDialog(context: context,dialogType: DialogType.success,title: 'Success',desc: 'Room Assign Successfully',btnOkOnPress: (){}).show();
      } else if (response.statusCode == 400) {
        var rawData = json.decode(response.body);
        AwesomeDialog(context: context,dialogType: DialogType.error,title: 'Error',btnOkOnPress: (){}).show();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(rawData['message']),
        ));
      } else if (response.statusCode > 400) {
        Navigator.of(context).pop();
        AwesomeDialog(context: context,dialogType: DialogType.error,title: 'Error',btnOkOnPress: (){}).show();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Something went wrong !! ${response.statusCode}'),
        ));
      } else {
        AwesomeDialog(context: context,dialogType: DialogType.error,title: 'Error',btnOkOnPress: (){}).show();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Something went wrong !! ${response.statusCode}'),
        ));
      }
    } catch (exception, trace) {
      print('Exception : $exception , Trace : $trace');
    }
  }


  _showAssignRoomDialog(String Room_No){

    TextEditingController roomNoController = TextEditingController();
    TextEditingController tenantIdController = TextEditingController();
    TextEditingController rentController= TextEditingController();
    TextEditingController remarksController= TextEditingController();
    roomNoController.text = Room_No;
    String? dropdownvalue;
    Map<String,String> formData = {};
    final _startDate = DateTime.now();
    late DateTime _startDateEnding ;
    final DateFormat _dateFormat = DateFormat('dd-MMM-yyyy');
    final _lastDate = DateTime.now().add(Duration(days: DateTime.now().year));
    List<String> items = ['Cash', 'Credit Card', 'PayPal', 'Bank Transfer'];
    showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Text('details'),
        content: StatefulBuilder(builder: (BuildContext context, void Function(void Function()) setState) {
          return  SafeArea(
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
                                  controller: tenantIdController,
                                  textInputType: TextInputType.number,
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
                                controller: rentController,
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
                                      firstDate: _startDate,
                                      lastDate: _lastDate,
                                    ).then((pickedDate){
                                      if(pickedDate !=null){
                                        setState(() {
                                          _startDateEnding = pickedDate.add(Duration(days: 1));
                                          if(formData.containsKey('startDate')){
                                            formData.update('startDate', (_)=>_dateFormat.format(pickedDate));
                                            formData.remove('endDate');
                                          }else{
                                            formData.putIfAbsent('startDate', ()=>_dateFormat.format(pickedDate));
                                          }
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
                                            child: Text( formData.containsKey('startDate')?formData['startDate']!:'start date',
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
                                  onTap: formData.containsKey('startDate')?() {
                                    showDatePicker(
                                      context: context,
                                      initialEntryMode: DatePickerEntryMode.calendarOnly,
                                      currentDate: _startDate,
                                      firstDate: _startDateEnding,
                                      lastDate: _lastDate,
                                    ).then((pickedDate){
                                      if(pickedDate !=null){
                                        setState(() {
                                          formData.putIfAbsent('endDate', ()=>_dateFormat.format(pickedDate));
                                        });
                                      }
                                    });
                                  }:()=> Fluttertoast.showToast(msg: 'first select starting date then ending'),
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
                                            child: Text(
                                              formData.containsKey('endDate')?formData['endDate']!:'end date',
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
                        controller: remarksController,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                        style: Theme.of(context).textTheme.bodySmall,
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
                      onPressed: () {
                        if(tenantIdController.text.isEmpty){
                          Fluttertoast.showToast(msg: 'Please enter tenant id',gravity: ToastGravity.TOP);
                          return;
                        }
                        if(dropdownvalue == null){
                          Fluttertoast.showToast(msg: 'Please select mode of payment',gravity: ToastGravity.TOP);
                          return;
                        }
                        if(rentController.text.isEmpty){
                          Fluttertoast.showToast(msg: 'Please enter paid amount',gravity: ToastGravity.TOP);
                          return;
                        }
                        if(!formData.containsKey('startDate')){
                          Fluttertoast.showToast(msg: 'Please select start date',gravity: ToastGravity.TOP);
                          return;
                        }
                        if(!formData.containsKey('endDate')){
                          Fluttertoast.showToast(msg: 'Please select end date',gravity: ToastGravity.TOP);
                          return;
                        }
                        if(remarksController.text.isEmpty){
                          Fluttertoast.showToast(msg: 'Please enter remarks',gravity: ToastGravity.TOP);
                          return;
                        }
                        _assignRoom({
                          "tenantId": tenantIdController.text,
                          "monthlyRent": rentController.text,
                          "roomNumber": Room_No,
                          "startDate": formData['startDate'],
                          "endDate": formData['endDate'],
                          "paymentMode": dropdownvalue,
                          "remarks": remarksController.text
                        });
                      },
                      child: Text('Assign',style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white),),
                    ),)
                ],
              ),
            ),
          );
        },
        ),
      );
    });
  }
}

class _roomList extends StatelessWidget{
  final Function(String) onSelection;
  _roomList({required this.onSelection,});


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
          height: 230,
          child: PageView.builder(
            itemCount: 4,
              itemBuilder: (context,index){
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Floor ${index + 1}'), // Display floor number
                      SizedBox(height: 5),
                      // GridView for rooms on this floor
                      SizedBox(
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



