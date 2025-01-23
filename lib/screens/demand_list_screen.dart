import 'package:flutter/material.dart';
import 'package:rental_admin_app/widgets/cust_button.dart';

import '../utilities/cust_color.dart';


class DemandListScreen extends StatefulWidget {
  @override
  _DemandListScreenState createState() => _DemandListScreenState();
}

class _DemandListScreenState extends State<DemandListScreen> {
  bool selectAll = false;
  List<Student> students = [
    Student(name: "Chandan Sharma", mobile: "8969893457", amount: 25000, selected: false),
    Student(name: "Saurav Sharma", mobile: "8969893457", amount: 25000, selected: false),
    Student(name: "Gautam Kumar", mobile: "8969893457", amount: 25000, selected: false),
    Student(name: "Sumit Kumar", mobile: "8969893457", amount: 25000, selected: true),
    Student(name: "Prabhat Raj", mobile: "8969893457", amount: 25000, selected: true),
  ];

  void toggleSelectAll(bool? value) {
    setState(() {
      selectAll = value ?? false;
      for (var student in students) {
        student.selected = selectAll;
      }
    });
  }

  void toggleStudentSelection(int index, bool? value) {
    setState(() {
      students[index].selected = value ?? false;
      selectAll = students.every((student) => student.selected);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Demand List"),
        foregroundColor: Colors.white,
        titleSpacing: 0,
        leading: Icon(Icons.arrow_back),
        backgroundColor: CustColor.Green,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
                  contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                ),
                hint: Text("Select month"),
                items: [],
                onChanged: (value) {},
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
                  contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                ),
                hint: Text("Select hostel"),
                items: [],
                onChanged: (value) {},
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
                  contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                ),
                hint: Text("Select floor"),
                items: [],
                onChanged: (value) {},
              ),
              SizedBox(height: 16),
              CustButton(label: 'Search', onPressed: (){}),
              SizedBox(height: 20),

              Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  width: 200,
                  child: CustButton(label: 'Generate Demand', onPressed: (){}),
                ),
              ),
              SizedBox(height: 16,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Students",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Text("Select all"),
                      Checkbox(
                        value: selectAll,
                        onChanged: toggleSelectAll,
                      ),
                    ],
                  ),
                ],
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: students.length,
                itemBuilder: (context, index) {
                  final student = students[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                student.name,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "mob: ${student.mobile}",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                          Text("₹ ${student.amount}", style: TextStyle(fontWeight: FontWeight.bold)),
                          Checkbox(
                            value: student.selected,
                            onChanged: (value) => toggleStudentSelection(index, value),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Student {
  String name;
  String mobile;
  int amount;
  bool selected;

  Student({
    required this.name,
    required this.mobile,
    required this.amount,
    this.selected = false,
  });
}