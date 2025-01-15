import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:rental_admin_app/utilities/is_vaild_email.dart';
import 'package:rental_admin_app/utilities/urls.dart';
import 'package:rental_admin_app/widgets/cust_button.dart';
import 'package:rental_admin_app/widgets/cust_circular_indicator.dart';
import 'package:rental_admin_app/widgets/cust_textfield.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utilities/consts.dart';
import '../utilities/cust_color.dart';
import 'dashboard.dart';

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
  bool _isLoading = false;
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();

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
    if(MediaQuery.of(context).viewInsets.bottom !=0){
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
            controller: _emailTextController,
            labelText: 'Email address',
            focusNode: emailFocusNode,
            textInputAction: TextInputAction.next,
            textInputType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 15),
          // Password Field
          CustTextField(
            controller: _passwordTextController,
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
          !_isLoading?CustButton(
            label: 'LOGIN',
            onPressed: _login
          ):CustCircularIndicator(),
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


  void _login() async {
    final String emailTxt = _emailTextController.text.trim();
    final String passwordTxt = _passwordTextController.text.trim();
    final List<ConnectivityResult> connectivityResult = await Connectivity().checkConnectivity();
    if (emailTxt.isEmpty) {
      emailFocusNode.requestFocus();
      return;
    }
    if (passwordTxt.isEmpty) {
      passwordFocusNode.requestFocus();
      return;
    }

    if(dropdownvalue==null){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('please select Admin role!'),
      ));
      return;
    }

    if(!isValidEmail(emailTxt)){
      emailFocusNode.requestFocus();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('please enter valid email address'),
      ));
      return;
    }

    if(!(connectivityResult.contains(ConnectivityResult.mobile)||connectivityResult.contains(ConnectivityResult.wifi)||connectivityResult.contains(ConnectivityResult.ethernet))){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('No Connections'),
      ));
      return;
    }
    setState(() {
      _isLoading = true;
    });

      try{
        var uri = Uri.parse(Urls.adminLoginUrl);
        print('dropdown selected value: $dropdownvalue');
        var body = json.encode({
          'hostelAdminEmail': emailTxt,
          'hostelAdminPassword': passwordTxt,
          'hostelAdminRole' : dropdownvalue??''
        });

        var response = await post(uri, body: body, headers: {
          'Content-Type': 'application/json',
        });


        if (response.statusCode == 200) {
          var rawData = json.decode(response.body);
          final pref = await SharedPreferences.getInstance();
         pref.setBool(Consts.IsLogin, true);
          pref.setString(Consts.Token, rawData['data']['user']['hostelAdminToken']);
          pref.setString(Consts.Email, rawData['data']['user']['hostelAdminEmail']);
          pref.setString(Consts.Admin_role, rawData['data']['user']['hostelAdminRole']);
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => Dashboard()),
                (route) => false,
          );
        } else if(response.statusCode == 400){
          var rawData = json.decode(response.body);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(rawData['message']),
          ));
        }else if(response.statusCode>400){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Something went wrong !! ${response.statusCode}'),
          ));
        }else{
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Something went wrong !! ${response.statusCode}'),
          ));
        }
      } catch (exception, trace) {
        print('Exception : $exception , Trace : $trace');
      }

    setState(() {
      _isLoading = false;
    });

  }
}
