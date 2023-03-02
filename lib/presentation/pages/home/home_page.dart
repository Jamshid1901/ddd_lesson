import 'package:ddd_lesson/application/filter_cubit/filter_cubit.dart';
import 'package:ddd_lesson/application/home_cubit/home_cubit.dart';
import 'package:ddd_lesson/application/home_cubit/home_cubit.dart';
import 'package:ddd_lesson/presentation/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../infastuctura/servis/app_helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  List listOfType = ["Kvartiralar", "Tijorat ko’chmas mulk", "Yangi uylar"];

  List listOfDis = ["0 km", "10 km", "20 km"];

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
          tabs: const [
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
          BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              return InkWell(
                onTap: () {
                  AppHelper.showCustomDialog(
                    initIndex: listOfType.indexOf(state.type),
                    context: context,
                    title: "Turi",
                    list: listOfType,
                    onSelect: (int index) {
                      context.read<HomeCubit>().changeType(listOfType[index]);
                    },
                  );
                },
                child: Container(
                  margin: EdgeInsets.only(top: 32),
                  width: double.infinity,
                  height: 200,
                  color: Styles.primaryColor,
                  child: Center(
                    child: BlocBuilder<HomeCubit, HomeState>(
                      builder: (context, state) {
                        return Text(
                          state.type,
                          style: TextStyle(color: Colors.white),
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          ),
          Expanded(
            child: TabBarView(controller: tabController, children: [
              ListView(children: [
                Text("Arenda"),
                Text("Arenda1"),
                InkWell(
                  onTap: () {
                    AppHelper.showCustomDialog(
                      context: context,
                      title: "Maydoni",
                      list: listOfDis,
                      onSelect: (int value) {},
                      initIndex: 0,
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    height: 200,
                    color: Styles.primaryColor,
                    child: Center(
                      child: BlocBuilder<HomeCubit, HomeState>(
                        builder: (context, state) {
                          return Text(
                            state.distance,
                            style: TextStyle(color: Colors.white),
                          );
                        },
                      ),
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
