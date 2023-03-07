
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NoInternetPage extends StatelessWidget {
  const NoInternetPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("NoInternetPage");
    return Scaffold(
      appBar: AppBar(),
      body:  Center(child: Column(
        children: [
          Text("No Internet"),
          Lottie.asset("assets/noInternet.json")
        ],
      ),),
    );
  }
}
