import 'dart:io';

bool isNullOrEmpty(String str) {
  return str == null || str.length == 0;
}

bool isNullOrEmptyList(List<Object> list) {
  return list == null || list.isEmpty;
}

class Util {
  static bool get isAndroid => Platform.isAndroid;

  static bool get isIOS => Platform.isIOS;
}
