
import 'package:flutter/material.dart';

class NoInternetPage extends StatelessWidget {
  const NoInternetPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("NoInternetPage");
    return Scaffold(
      appBar: AppBar(),
      body: const Center(child: Text("No Internet"),),
    );
  }
}
