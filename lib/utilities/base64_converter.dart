import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';

ImageProvider base64ToImage(String base64String) {
  Uint8List bytes = base64Decode(base64String);
  return MemoryImage(bytes);
}
