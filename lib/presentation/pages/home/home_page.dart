import 'package:auto_route/auto_route.dart';
import 'package:ddd_lesson/application/filter_cubit/filter_cubit.dart';
import 'package:ddd_lesson/application/home_cubit/home_cubit.dart';
import 'package:ddd_lesson/application/home_cubit/home_cubit.dart';
import 'package:ddd_lesson/domain/model/room_model.dart';
import 'package:ddd_lesson/presentation/components/zoom_tab_animation.dart';
import 'package:ddd_lesson/presentation/pages/home/admob_page.dart';
import 'package:ddd_lesson/presentation/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ddd_lesson/presentation/route.gr.dart';
import 'package:rive/rive.dart';
import '../../../infastuctura/servis/app_helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController tabController;
  late RiveAnimationController _controller;
  late RiveAnimationController _controllerTwo;
  List listOfType = ["Kvartiralar", "Tijorat ko’chmas mulk", "Yangi uylar"];

  List listOfDis = ["0 kv", "10 kv", "20 kv"];

  // List<Room> listOfRoom = [Room(title: "1 xona"),Room(title: "2 xona")];

  List<Room> listOfRoom =
      List.generate(6, (index) => Room(title: "$index xona"));

  bool isPlaying = false;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    _controller = OneShotAnimation(
      'StartLoading',
      autoplay: false,
      onStop: () => setState(() => isPlaying = false),
      onStart: () => setState(() => isPlaying = true),
    );

    _controllerTwo = SimpleAnimation("FinishLoading", autoplay: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("HomePage");
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: Scaffold(
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
                      onSelectList: (List<dynamic>? value) {},
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 32),
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
                SardorAnimation(
                  child: RiveAnimation.asset(
                    'assets/ball_loader.riv',
                    animations: const [
                      "FinishLoading",
                      'Loading',
                      'StartLoading'
                    ],
                    antialiasing: false,
                    controllers: [_controller, _controllerTwo],
                  ),
                ),
                ListView(children: [
                  Text("Arenda"),
                  TextButton(
                      onPressed: () {
                        context.pushRoute(const SeeAllRoute());
                      },
                      child: Text("Arenda1")),
                  InkWell(
                    onTap: () {
                      AppHelper.showCustomDialog(
                        context: context,
                        title: "Xona",
                        multiSelected: true,
                        list: listOfRoom,
                        onSelect: (int value) {},
                        initIndex: 0,
                        onSelectList: (List<dynamic>? value) {
                          listOfRoom = value as List<Room>;
                          context.read<HomeCubit>().refresh();
                        },
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      height: 200,
                      color: Styles.primaryColor,
                      child: Center(
                        child: BlocBuilder<HomeCubit, HomeState>(
                          builder: (context, state) {
                            return Row(
                              children: [
                                ...listOfRoom.map((e) {
                                  return e.isActive
                                      ? Text(
                                          e.title,
                                          style: const TextStyle(
                                              color: Colors.white),
                                        )
                                      : const SizedBox.shrink();
                                }),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  )
                ]),
              ]),
            ),
          ],
        ),
        floatingActionButton: Row(
          children: [
            FloatingActionButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => const AdmobPage()));
                // isPlaying ? null : _controller.isActive = true;
                // setState(() {});
              },
              tooltip: isPlaying ? 'Pause' : 'Play',
              child: Icon(
                isPlaying ? Icons.pause : Icons.play_arrow,
              ),
            ),
            FloatingActionButton(onPressed: () {
              _controller.dispose();
              _controllerTwo.isActive = true;
              _controllerTwo.dispose();
            })
          ],
        ),
      ),
    );
  }
}
