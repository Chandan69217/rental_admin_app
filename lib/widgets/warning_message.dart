import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rental_admin_app/utilities/cust_color.dart';

class ShowWarning extends StatelessWidget {
  final String titile, desc;
  final VoidCallback onPressed;
  ShowWarning({required this.titile, this.desc = '', required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                titile,
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w400),
              ),
              if(desc != '') Padding(
                padding: EdgeInsets.symmetric(horizontal: 70),
                child: Text(desc,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 13,
                        color: Colors.black54,
                        fontWeight: FontWeight.w400)),
              ),
              SizedBox(height: 14,),
              ElevatedButton(
                onPressed: onPressed,
                child: Text('Retry'),
                style: ButtonStyle(
                  shape: WidgetStatePropertyAll(RoundedRectangleBorder()),
                  backgroundColor: WidgetStatePropertyAll(CustColor.Green),
                  foregroundColor:
                  WidgetStatePropertyAll(Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}