import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rental_admin_app/widgets/cust_button.dart';
import 'package:rental_admin_app/widgets/cust_textfield.dart';

import '../utilities/cust_color.dart';

class SignupScreen extends StatefulWidget {
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> with WidgetsBindingObserver {
  String? dropdownvalue;
  static final items =  ['Manager','Owner','Warden'];
  bool obscureTextNewPassword = true;
  bool obscureTextConfirmPassword = true;
  int _currentStep = 0;
  final FocusNode newPasswordFocusNode = FocusNode();
  final FocusNode confirmPasswordFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode phoneFocusNode = FocusNode();
  final FocusNode nameFocusNode = FocusNode();
  final PageController _pageController = PageController();
  final GlobalKey<FormState> _step1Key = GlobalKey<FormState>();
  final GlobalKey<FormState> _step2Key = GlobalKey<FormState>();
  final GlobalKey<FormState> _step3Key = GlobalKey<FormState>();

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
        newPasswordFocusNode.unfocus();
        confirmPasswordFocusNode.unfocus();
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
                "signed up, you'll gain full access to the admin dashboard where you can monitor your hostels, manage tenant.",
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                  fontSize: 14,
                  color: CustColor.Gray,
                ),
              ),
              const SizedBox(height: 15),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    _step1(),
                    _step2(),
                    _step3()
                  ],
                  onPageChanged: (page){
                    setState(() {
                      _currentStep = page;
                    });
                  },
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  if (_currentStep > 0)
                    CustButton(
                      label: "Previous",
                      onPressed: () {
                        if (_currentStep > 0) {
                          _pageController.previousPage(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.ease,
                          );
                        }
                      },
                    ),

                  Expanded(
                    child: Center(
                      child: Text(
                        'Step ${_currentStep + 1}/3',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),

                  if (_currentStep < 2)
                    CustButton(
                      label: "Next",
                      onPressed: () {
                        if (_currentStep == 0 && _step1Key.currentState!.validate()) {
                          _pageController.nextPage(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.ease,
                          );
                        } else if (_currentStep == 1 && _step2Key.currentState!.validate()) {
                          _pageController.nextPage(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.ease,
                          );
                        }
                      },
                    ),
                ],
              ),

              const SizedBox(
                height: 10,
              ),
            ],
          )),
    );
  }

  Widget _step1(){
      return Form(
        key: _step1Key,
        child: Column(
          children: [
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
              labelText: 'Name',
              focusNode: nameFocusNode,
              textInputType: TextInputType.text,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 15),
            // Password Field
            CustTextField(
              labelText: 'Email Address',
              focusNode: emailFocusNode,
              textInputType: TextInputType.text,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 15),
            CustTextField(
              labelText: 'Phone No',
              focusNode: phoneFocusNode,
              textInputType: TextInputType.text,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 15),
          ],
        ),
      );
  }

  Widget _step2(){
    return Form(
      key: _step2Key,
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [CircleAvatar(
              backgroundImage: AssetImage('assets/icons/dummy_profile.webp',),
              radius: 100,
            ), Container(padding: EdgeInsets.all(15.0),decoration: BoxDecoration(color:CustColor.Green,shape: BoxShape.circle),child: Icon( FontAwesomeIcons.camera,color: Colors.white,)),
            ]
          ),
          SizedBox(height: 20,),
          Expanded(child: Text('Select your profile'))
        ],
      ),
    );
  }

  Widget _step3(){
    return Form(
      key: _step3Key,
      child: Column(
        children: [
          // Email Field
          SizedBox(height: 15,),
          CustTextField(
            labelText: 'New Password',
            focusNode: newPasswordFocusNode,
            textInputType: TextInputType.text,
            textInputAction: TextInputAction.next,
            obscureText: obscureTextNewPassword,
            enableSuffix: true,
            onTap: (){
              setState(() {
                obscureTextNewPassword = !obscureTextNewPassword;
              });
            },
          ),
          const SizedBox(height: 15),
          // Password Field
          CustTextField(
            labelText: 'Confirm Password',
            focusNode: confirmPasswordFocusNode,
            textInputType: TextInputType.text,
            textInputAction: TextInputAction.next,
            enableSuffix: true,
            obscureText: obscureTextConfirmPassword,
            onTap: (){
              setState(() {
                obscureTextConfirmPassword = !obscureTextConfirmPassword;
              });
            },
          ),
          const SizedBox(height: 30),
          CustButton(label: 'Sign Up', onPressed: (){})
        ],
      ),
    );
  }

}
