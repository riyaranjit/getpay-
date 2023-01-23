import 'dart:convert';
import 'dart:typed_data';

import 'package:dynamic_form/utils/log_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

MemoryImage base64ToProvider(String base64){
  Uint8List bytes = base64Decode(base64);
  return MemoryImage(bytes);
}

Uint8List base64ToBytes(String base64){
  Uint8List bytes = base64Decode(base64);
  return bytes;
}

String bytesToBase64(Uint8List bytes) {
  String base64Content = base64Encode(List.from(bytes));
  return base64Content;
}

Future<String> fileToBase64(String path, {int width, int quality = 50}) async{
  try {
    var result = await FlutterImageCompress.compressWithFile(
      path,
      minWidth: width,
      quality: quality,
    );
    return base64Encode(result);
  } catch (e) {
    appLog("EXP" + e);
  }
}

compressUintList(Uint8List list,{int width=600,int quality = 50}) async {
  var result = await FlutterImageCompress.compressWithList(
    list,
    minWidth: width,
    quality: quality,
  );
  return result;
}