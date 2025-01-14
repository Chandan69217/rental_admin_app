import 'package:hive/hive.dart';

Future<void> storeUserData({required String to,required String key,required Map<String, dynamic> userData}) async {
  var box = await Hive.openBox(to);
  await box.put(key, userData);
}

Future<Map<String, dynamic>?> getUserData({required String from, required String key}) async {
  var box = await Hive.openBox(from);
  var data = box.get(key);
  if (data is Map) {
    return Map<String, dynamic>.from(data);
  }
  return null;
}
