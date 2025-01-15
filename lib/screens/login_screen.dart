import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rental_admin_app/screens/signup_screen.dart';
import 'package:rental_admin_app/widgets/cust_button.dart';
import 'package:rental_admin_app/widgets/cust_textfield.dart';

import '../utilities/cust_color.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with WidgetsBindingObserver {
  String? dropdownvalue;
  static final items =  ['Manager','Owner','Warden'];
  bool obscureText = true;
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    if(MediaQuery.of(context).viewInsets.bottom != 0){
      if(View.of(context).viewInsets.bottom == 0){
        emailFocusNode.unfocus();
        passwordFocusNode.unfocus();
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustColor.Background,
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 20,
          ),
          // Text(
          //   'Login',
          //   style: GoogleFonts.roboto(
          //     fontSize: 36,
          //     fontWeight: FontWeight.bold,
          //   ),
          // ),
          // Description
          Text(
            'By logging in, you can manage hostels & monitor tenant details, and oversee hostel operations with ease.',
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(
              fontSize: 14,
              color: CustColor.Gray,
            ),
          ),
          const SizedBox(height: 10),

          Align(
            alignment: Alignment.bottomRight,
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                elevation: 0,
                value: dropdownvalue,
                hint: Text('Admin role'),
                icon: Icon(Icons.keyboard_arrow_down),
                dropdownColor: CustColor.Light_Green,
                borderRadius: BorderRadius.circular(8.0),
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
          // Email Field
          CustTextField(
            labelText: 'Email address',
            focusNode: emailFocusNode,
            textInputAction: TextInputAction.next,
            textInputType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 15),
          // Password Field
          CustTextField(
            enableSuffix: true,
            obscureText: obscureText,
            labelText: 'Password',
            focusNode: passwordFocusNode,
            textInputAction: TextInputAction.done,
            textInputType: TextInputType.text,
            onTap: ()=> setState(() {
              obscureText = !obscureText;
            }),
          ),
          const SizedBox(height: 30),
          // Login Button
          CustButton(
            label: 'LOGIN',
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SignupScreen())),
          ),
          Align(
            alignment: Alignment.topRight,
            child: TextButton(
              onPressed: () {},
              child: Text(
                'Forgot Password?',
                style: GoogleFonts.roboto(
                  fontSize: 14,
                  color: Color(0xFF3B5998),
                ),
              ),
            ),
          ),
          Spacer(),
          // Social Icons
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(FontAwesomeIcons.facebookF),
                  color: Color(0xFF3B5998),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(FontAwesomeIcons.twitter),
                  color: Color(0xFF3B5998),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(FontAwesomeIcons.envelope),
                  color: Color(0xFF3B5998),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      )),
    );
  }
}
