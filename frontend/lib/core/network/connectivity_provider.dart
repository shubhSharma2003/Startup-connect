import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final connectivityProvider = StreamProvider<ConnectivityResult>((ref) {
  return Connectivity().onConnectivityChanged.map((results) {
    if (results.isEmpty) return ConnectivityResult.none;
    return results.first; // Returning the first available connectivity status
  });
});
