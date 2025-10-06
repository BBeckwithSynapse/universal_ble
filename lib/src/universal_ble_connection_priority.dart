import 'dart:io';

import 'package:flutter/services.dart';

enum UbleConnectionPriority { balanced, high, lowPower }

const _ubleChannel = MethodChannel('universal_ble/methods');

class UniversalBleConnectionPriority {
  static const MethodChannel _ch = MethodChannel('universal_ble/conn_priority'); // <- must match Kotlin

  static Future<void> setPriority(String deviceId, UbleConnectionPriority p) {
    if (!Platform.isAndroid) {
      return Future.value();
    }
    final code = switch (p) {
      UbleConnectionPriority.high => 1,
      UbleConnectionPriority.lowPower => 2,
      UbleConnectionPriority.balanced => 0,
    };
    return _ch.invokeMethod('setConnectionPriority', {'deviceId': deviceId, 'priority': code});
  }
}
