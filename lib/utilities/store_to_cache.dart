import 'package:hive/hive.dart';

Future<void> storeUserData({required String key,required Map<String, dynamic> userData}) async {
  var box = await Hive.openBox('dashboardBox');
  await box.put(key, userData);
}

Future<void> storeAttendanceFilterData({required String key,required List<dynamic> userData}) async {
  var box = await Hive.openBox('dashboardBox');
  await box.put(key, userData);
}

Future<List<Map<String,dynamic>>> getAttendanceFilterData({required String key,}) async {
  var box = await Hive.openBox('dashboardBox');
  var data = box.get(key);
  if (data is List) {
    return List<Map<String, dynamic>>.from(
        data.map((e) => Map<String, dynamic>.from(e))
    );
  }
  return [];
}


Future<Map<String, dynamic>?> getUserData({required String key}) async {
  var box = await Hive.openBox('dashboardBox');
  var data = box.get(key);
  if (data is Map) {
    return Map<String, dynamic>.from(data);
  }
  return null;
}
