import 'package:ddd_lesson/presentation/styles/styles.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        bottom: TabBar(
          controller: tabController,
          indicatorColor: Styles.primaryColor,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
          labelStyle: TextStyle(fontSize: 20),
          unselectedLabelStyle: TextStyle(fontSize: 16),
          tabs: [
            Tab(
              text: "Arenda",
            ),
            Tab(
              text: "Sotib olish",
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 32),
            width: double.infinity,
            height: 200,
            color: Styles.primaryColor,
            child: Center(
              child: Text(
                "Container",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Expanded(
            child: TabBarView(controller: tabController, children: [
              ListView(children: [
                Text("Arenda"),
                Text("Arenda1"),
                Container(
                  width: double.infinity,
                  height: 200,
                  color: Styles.primaryColor,
                  child: Center(
                    child: Text(
                      "Container",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              ]),
              Text("Sotib olish"),
            ]),
          ),
        ],
      ),
    );
  }
}
