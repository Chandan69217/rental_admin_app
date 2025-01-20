import 'dart:convert';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rental_admin_app/utilities/base64_converter.dart';
import 'package:rental_admin_app/utilities/is_vaild_email.dart';
import 'package:rental_admin_app/widgets/cust_button.dart';
import 'package:rental_admin_app/widgets/cust_circular_indicator.dart';
import 'package:rental_admin_app/widgets/cust_textfield.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utilities/consts.dart';
import '../utilities/cust_color.dart';
import '../utilities/urls.dart';

class SignupScreen extends StatefulWidget {
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> with WidgetsBindingObserver {

  static final items =  ['Manager','Owner','Warden'];
  bool obscureTextNewPassword = true;
  bool obscureTextConfirmPassword = true;
  int _currentStep = 0;
  bool _isLoading = false;
  final FocusNode newPasswordFocusNode = FocusNode();
  final FocusNode confirmPasswordFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode phoneFocusNode = FocusNode();
  final FocusNode nameFocusNode = FocusNode();
  final TextEditingController _nameTxtEditingController = TextEditingController();
  final TextEditingController _emailTxtEditingController = TextEditingController();
  final TextEditingController _phoneTxtEditingController = TextEditingController();
  final TextEditingController _newPassTxtEditingController = TextEditingController();
  final TextEditingController _confirmPassTxtEditingController = TextEditingController();
  final PageController _pageController = PageController();
  final GlobalKey<FormState> _step1Key = GlobalKey<FormState>();
  final GlobalKey<FormState> _step2Key = GlobalKey<FormState>();
  final GlobalKey<FormState> _step3Key = GlobalKey<FormState>();

  String? name;
  String? email;
  String? phone;
  String? admin_role;
  String? newPassword;
  String? confirmPassword;
  String? profile;

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
              // const SizedBox(
              //   height: 20,
              // ),
              // Description
              // Text(
              //   "signed up, you'll gain full access to the admin dashboard where you can monitor your hostels, manage tenant.",
              //   textAlign: TextAlign.center,
              //   style: GoogleFonts.roboto(
              //     fontSize: 14,
              //     color: CustColor.Gray,
              //   ),
              // ),
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
                    Opacity(
                      opacity: _currentStep > 0 ? 1:0,
                      child: SizedBox(
                        width: 100,
                        child: CustButton(
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
                      ),
                    ),

                  Expanded(
                    child: Center(
                      child: Text(
                        'Step ${_currentStep + 1}/3',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),

                    Opacity(
                      opacity: _currentStep < 2 ?1:0,
                      child: SizedBox(
                        width: 100,
                        child: CustButton(
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
                      ),
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
                  value: admin_role,
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
                      admin_role = newValue!;
                    });
                  },

                ),
              ),
            ),
            // Email Field
            CustTextField(
              controller: _nameTxtEditingController,
              onChanged: (value){
                name = value;
              },
              labelText: 'Name',
              focusNode: nameFocusNode,
              textInputType: TextInputType.text,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 15),
            // Password Field
            CustTextField(
              controller: _emailTxtEditingController,
              onChanged: (value){
                email = value;
              },
              labelText: 'Email Address',
              focusNode: emailFocusNode,
              textInputType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 15),
            CustTextField(
              controller: _phoneTxtEditingController,
              onChanged: (value){
                phone = value;
              },
              labelText: 'Phone No',
              focusNode: phoneFocusNode,
              textInputType: TextInputType.phone,
              maxLength: 10,
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
              backgroundImage: profile != null ? base64ToImage(profile!):AssetImage('assets/icons/dummy_profile.webp',),
              radius: 80,
            ), GestureDetector(onTap:_selectProfile ,child: Container(padding: EdgeInsets.all(15.0),decoration: BoxDecoration(color:CustColor.Green,shape: BoxShape.circle),child: Icon( FontAwesomeIcons.camera,color: Colors.white,))),
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
            controller: _newPassTxtEditingController,
            onChanged: (value){
              newPassword = value;
            },
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
            controller: _confirmPassTxtEditingController,
            onChanged: (value){
              confirmPassword = value;
            },
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
          _isLoading ? CustCircularIndicator():CustButton(label: 'Sign Up', onPressed: _signup)
        ],
      ),
    );
  }


  void _selectProfile() async{
    if(await _checkPermissions(context)){
      showModalBottomSheet(context: context,
          useSafeArea: true,
          showDragHandle: true,
          elevation: 0,
          backgroundColor: CustColor.Background,
          constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.2),
          builder: (context){
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: _pickImageFromGallery,
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: const Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.photo,size: 50,),
                          Text('Gallery'),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: _takePhoto,
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: const Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.camera_alt,size: 50,),
                          Text('Camera')
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          });
    }
  }

  Future<void> _pickImageFromGallery() async {
    var image_picker = ImagePicker();
    final XFile? pickedFile = await image_picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profile = await convertImageToBase64(pickedFile);
      setState(() {
        Navigator.of(context).pop();
      });
    }
  }

  Future<void> _takePhoto() async {
    var image_picker = ImagePicker();
    final XFile? pickedFile = await image_picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      profile = await convertImageToBase64(pickedFile);
      setState(() {
        Navigator.of(context).pop();
      });
    }
  }


  Future<bool> _checkPermissions(BuildContext context) async {

    PermissionStatus cameraStatus = await Permission.camera.request();


    if (cameraStatus.isDenied) {
      await _requestPermissions(context);
      return false;
    }

    if (cameraStatus.isGranted) {
      return true;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Camera and Gallery permissions are required')),
    );
    return false;
  }
  Future<bool> _requestPermissions(BuildContext context) async {
    PermissionStatus cameraStatus = await Permission.camera.request();
    if (cameraStatus.isDenied) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Permissions are still denied')),
      );
      _showSettingsDialog(context);
      return false;
    }else if(cameraStatus.isPermanentlyDenied){
      _showSettingsDialog(context);
      return false;
    }else{
      return true;
    }
  }
  void _showSettingsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Open App Settings'),
          content: Text('Allow gallery and camera permissions manually. Press OK to open the settings.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                openAppSettings();
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }



  void _signup()async {
    if(admin_role==null){
      _pageController.jumpToPage(0);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('please select admin role'),
      ));
      return;
    }

    if(name==null||name!.isEmpty){
      _pageController.jumpToPage(0);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Enter your name'),
      ));
      return;
    }
    if(email==null||email!.isEmpty){
      _pageController.jumpToPage(0);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Enter email address'),
      ));
      return;
    }else if(!isValidEmail(email!)){
      _pageController.jumpToPage(0);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Enter valid email address'),
      ));
      return;
    }

    if(phone==null||phone!.isEmpty){
      _pageController.jumpToPage(0);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Enter your phone no'),
      ));
      return;
    }else if(phone!.length!=10){
      _pageController.jumpToPage(0);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Enter valid phone number'),
      ));
      return;
    }

    if(profile == null){
      _pageController.jumpToPage(1);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please select your profile'),
      ));
      return;
    }

    if(newPassword == null || confirmPassword == null){
      _pageController.jumpToPage(2);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('please create your password'),
      ));
      return;
    }else if(newPassword != confirmPassword){
      _pageController.jumpToPage(2);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("new password & confirm password doesn't match"),
      ));
      return;
    }
    // var pref = await SharedPreferences.getInstance();
    // var token = pref.getString(Consts.Token)??'';
    //
    //   if(token.isEmpty){
    //     print('user token not available');
    //     return;
    //   }
    final List<ConnectivityResult> connectivityResult = await Connectivity().checkConnectivity();
    if(!(connectivityResult.contains(ConnectivityResult.mobile)||connectivityResult.contains(ConnectivityResult.wifi)||connectivityResult.contains(ConnectivityResult.ethernet))){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('No Connections'),
      ));
      return;
    }
    setState(() {
      _isLoading = true;
    });

    try{
      var uri = Uri.https(Urls.baseUrl,Urls.adminRegisterUrl);

      var body = json.encode({
        "hostelAdminName": name,
        "hostelAdminEmail": email,
        "hostelAdminPassword": newPassword,
        "hostelAdminRole": admin_role,
        "hostelAdminPhoneNumber": phone,
        "hostelAdminProfileImage": profile
      });

      var response = await post(uri, body: body, headers: {
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        var rawData = json.decode(response.body);
        if(rawData['status']){
          clear();
          AwesomeDialog(context: context,
              dialogType: DialogType.success,
              animType: AnimType.bottomSlide,
              title: 'Register Successful',
              desc: 'Go to login screen and use your valid email & password',
              descTextStyle: Theme.of(context).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.normal,color: CustColor.Gray),
              btnOkOnPress: (){}
          ).show();
        }
      } else if(response.statusCode == 400){
        var rawData = json.decode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(rawData['message']),
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

  void clear(){
    setState(() {
      admin_role = null;
      name = null;
      email = null;
      phone = null;
      profile = null;
      newPassword = null;
      confirmPassword = null;
      _nameTxtEditingController.text = '';
      _emailTxtEditingController.text = '';
      _phoneTxtEditingController.text = '';
      _newPassTxtEditingController.text = '';
      _confirmPassTxtEditingController.text = '';
      _pageController.jumpToPage(0);
    });
  }
}
