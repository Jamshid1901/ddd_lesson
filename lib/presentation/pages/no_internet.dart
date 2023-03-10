import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;

class NoInternetPage extends StatefulWidget {
  const NoInternetPage({Key? key}) : super(key: key);

  @override
  State<NoInternetPage> createState() => _NoInternetPageState();
}

class _NoInternetPageState extends State<NoInternetPage> {
  var controller = MaskedTextController(mask: '00/00');
  String? fcmToken = "";

  @override
  void initState() {
    getToken();
    super.initState();
  }

  Future<void> getToken() async {
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      sound: true,
    );
    fcmToken = await FirebaseMessaging.instance.getToken();
    print(fcmToken);
    FirebaseMessaging.onMessage.listen((event) {
      print(event.data);
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    event.data["body"] ?? "body",
                    style: TextStyle(color: Colors.black),
                  ),
                  Text(event.data["title"] ?? "title",
                      style: TextStyle(color: Colors.black)),
                ],
              ),
            );
          });
    });

    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      print("onMessageOpenedApp : $event");
    });

    FirebaseMessaging.onBackgroundMessage((message) {
      print("onBackgroundMessage : $message");
      return Future.value();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            const Text("No Internet"),
            TextFormField(
              controller: controller,
              decoration: const InputDecoration(labelText: "Card number"),
            ),
            Lottie.asset("assets/noInternet.json")
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          http.post(
            Uri.parse("https://fcm.googleapis.com/fcm/send"),
            headers: {
              "Content-Type": "application/json",
              'Authorization':
                  'key=AAAAqJD8HH8:APA91bEmca9J3IlZqn5xnQw7VsWvnERek76AE28rCJWMSV-afz3RNqbAkaPyP02KolAoQbhxVbSbnTQnnQ31Mx0o5PrlzFmLiv3_XNYCJ7g0k9okQDdJ6onoKSzo2euACXpdeON3Hu2-'
            },
            body: jsonEncode(
              {
                "to": fcmToken,
                "data": {
                  "body": "Sizning kartangizdan *** summa yechib olindi",
                  "title": "Biz bn ishlaganiz raxmat !!!"
                }
              },
            ),
          );
        },
      ),
    );
  }
}
