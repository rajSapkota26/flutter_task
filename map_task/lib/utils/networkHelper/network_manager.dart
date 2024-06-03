import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';

/// Manages the network connectivity status and provides methods to check and handle connectivity changes.
class NetworkManager {
  /// Check the internet connection status.
  /// Returns `true` if connected, `false` otherwise.
  static Future<bool> isConnected() async {
    try {
      final Connectivity connectivity = Connectivity();
      final List<ConnectivityResult> result =
          await connectivity.checkConnectivity();
      if (result.contains(ConnectivityResult.none)) {
        return false;
      } else {
        return true;
      }
    } on PlatformException catch (_) {
      return false;
    }
  }
}
