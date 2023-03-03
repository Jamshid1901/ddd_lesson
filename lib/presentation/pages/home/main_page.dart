import 'package:auto_route/auto_route.dart';
import 'package:ddd_lesson/presentation/route.gr.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: const [
        HomeRoute(),
        NoInternetRoute(),
        UserRoute(),
      ],
      builder: (context, child, animation) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
            body: FadeTransition(
              opacity: animation,
              child: child,
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: tabsRouter.activeIndex,
              onTap: (index) {
                tabsRouter.setActiveIndex(index);
              },
              items: const [
                BottomNavigationBarItem(
                    label: 'Users', icon: Icon(Icons.person)),
                BottomNavigationBarItem(label: 'Posts', icon: Icon(Icons.home)),
                BottomNavigationBarItem(
                    label: 'Settings', icon: Icon(Icons.search)),
              ],
            ));
      },
    );
  }
}
