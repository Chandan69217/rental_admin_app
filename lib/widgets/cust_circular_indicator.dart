import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../utilities/cust_color.dart';

class CustCircularIndicator extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return SizedBox(width:25,height:25,child: CircularProgressIndicator(color: CustColor.Green,));
  }
  
}