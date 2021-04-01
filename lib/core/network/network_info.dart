import 'package:connectivity/connectivity.dart';

class NetworkInfo {
  final Connectivity connectionChecker;

  NetworkInfo({required this.connectionChecker});

  Future<bool> isConnected() async {
    try {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.none) {
        return false;
      }
      return true;
    } on Exception {
      return false;
    }
  }
}
