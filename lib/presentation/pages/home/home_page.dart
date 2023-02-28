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
        bottom: TabBar(
          controller: tabController,
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
            child: TabBarView(controller: tabController,
                children: [
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
