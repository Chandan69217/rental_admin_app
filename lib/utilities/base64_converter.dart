import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

ImageProvider base64ToImage(String base64String) {
  Uint8List bytes = base64Decode(base64String);
  return MemoryImage(bytes);
}


Future<String?> convertImageToBase64(XFile imageFile) async {
  try {
    final bytes = await imageFile.readAsBytes();
    String base64String = base64Encode(bytes);
    return base64String;
  } catch (e) {
    print("Error converting image to Base64: $e");
    return null;
  }
}

