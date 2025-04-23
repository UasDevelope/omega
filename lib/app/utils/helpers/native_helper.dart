// lib/app/utils/native_helper.dart

import 'package:flutter/services.dart';

class NativeHelper {
  static const MethodChannel _channel = MethodChannel('com.apex.app/info');

  static Future<String> getAppVersion() async {
    try {
      final String version = await _channel.invokeMethod('getAppVersion');
      return version;
    } catch (e) {
      return 'Unknown';
    }
  }
}
