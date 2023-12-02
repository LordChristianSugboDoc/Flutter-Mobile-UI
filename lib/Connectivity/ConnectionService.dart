import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/services.dart';

class NetworkInfo {
  static const MethodChannel _channel = const MethodChannel('network_info');

  static Future<String?> get localIpAddress async {
    try {
      final String result = await _channel.invokeMethod('getLocalIpAddress');
      return result;
    } on PlatformException catch (e) {
      print("Error getting local IP address: ${e.message}");
      return null;
    }
  }

  static Future<bool> isConnected() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult != ConnectivityResult.none;
  }
}
