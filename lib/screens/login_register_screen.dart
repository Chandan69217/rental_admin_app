import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rental_admin_app/screens/login_screen.dart';
import 'package:rental_admin_app/screens/signup_screen.dart';
import 'package:rental_admin_app/utilities/cust_color.dart';

class LoginRegisterScreen extends StatefulWidget {
  @override
  State<LoginRegisterScreen> createState() => _LoginRegisterScreenState();
}

class _LoginRegisterScreenState extends State<LoginRegisterScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: CustColor.Background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  _tabController.index == 0 ? 'assets/icons/plant.webp' : 'assets/icons/Sign_up.webp',
                  width: screenWidth * 0.6,
                  height: screenWidth * 0.6,
                ),
                const SizedBox(height: 10),
                Text(
                  _tabController.index == 0 ? 'Welcome Back' : 'Register',
                  style: GoogleFonts.poppins(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: TabBar(
                    controller: _tabController,
                    indicatorColor: CustColor.Green,
                    unselectedLabelColor: CustColor.Green,
                    dividerColor: Colors.transparent,
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicator: BoxDecoration(
                      color: _tabController.index == 0 ? CustColor.Green : CustColor.Pink,
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: const [
                        BoxShadow(
                          color: CustColor.Light_Green,
                          spreadRadius: 2,
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    tabs: <Tab>[
                      Tab(
                        child: Text(
                          'Login',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            color: _tabController.index == 0 ? Colors.white : CustColor.Green,
                          ),
                        ),
                      ),
                      Tab(
                        child: Text(
                          'Sign Up',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            color: _tabController.index == 1 ? Colors.white : CustColor.Pink,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                SizedBox(
                  height: screenHeight * 0.55,
                  child: TabBarView(
                    controller: _tabController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      LoginScreen(),
                      SignupScreen(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
