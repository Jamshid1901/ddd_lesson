import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ddd_lesson/presentation/pages/home/home_page.dart';
import 'package:ddd_lesson/presentation/pages/no_internet.dart';
import 'package:flutter/material.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StreamBuilder(
          stream: Connectivity().onConnectivityChanged,
          builder: (context, data) {
            if (data.data == ConnectivityResult.mobile ||
                data.data == ConnectivityResult.wifi) {
              // http.get("https://www.google.com/");
              return const HomePage();
            } else {
              return const NoInternet();
            }
          }),
    );
  }
}

abstract class AppConnectivity {

  AppConnectivity._();

  static Future<bool> connectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }
}

// static showNoConnectionSnackBar(BuildContext context) {
//   ScaffoldMessenger.of(context).hideCurrentSnackBar();
//   final snackBar = SnackBar(
//     backgroundColor: Style.brandGreen,
//     behavior: SnackBarBehavior.floating,
//     duration: const Duration(seconds: 3),
//     content: Text(
//       'No internet connection',
//       style: Style.interNoSemi(
//         size: 14,
//         color: Style.white,
//       ),
//     ),
//     action: SnackBarAction(
//       label: 'Close',
//       disabledTextColor: Style.black,
//       textColor: Style.black,
//       onPressed: () {
//         ScaffoldMessenger.of(context).hideCurrentSnackBar();
//       },
//     ),
//   );
//   ScaffoldMessenger.of(context).showSnackBar(snackBar);
// }
