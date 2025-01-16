import 'package:flutter/cupertino.dart';

class DashboardData{
static ImageProvider? profile;
static String? Name;
static int? user_id;
static String? MobileNo;
static String? EmailID;
static String? Role;
static String? Password;
static String? token;
static List<Map<String,dynamic>>? hostels;

static void clearData() {
  profile = null;
  Name = null;
  MobileNo = null;
  EmailID = null;
  Role = null;
  Password = null;
  hostels = null;
  token = null;
  user_id = null;
}

}