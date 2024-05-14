import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  ConnectivityService._internal(); // Private constructor

  static final ConnectivityService _instance = ConnectivityService._internal();

  factory ConnectivityService() {
    return _instance; // Return the same instance
  }

  static isAvailable() async {
    if (await Connectivity().checkConnectivity() != ConnectivityResult.none) {
      return true;
    }
    return false;
  }
}
