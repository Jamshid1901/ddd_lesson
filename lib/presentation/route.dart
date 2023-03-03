import 'package:auto_route/auto_route.dart';
import 'package:ddd_lesson/presentation/pages/home/home_page.dart';
import 'package:ddd_lesson/presentation/pages/no_internet.dart';

import 'pages/home/main_page.dart';
import 'pages/home/see_all.dart';
import 'pages/home/user_page.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    MaterialRoute(
      path: '/',
      page: DashboardPage,
      children: [
        MaterialRoute(path: 'home', page: HomePage, initial: true),
        MaterialRoute(
          path: 'internet',
          page: NoInternetPage,
          initial: true,
        ),
        MaterialRoute(
          path: 'user',
          page: UserPage,
          initial: false,
        ),
      ],
    ),
    MaterialRoute(
      path: 'see-all',
      page: SeeAllPage,
    ),
  ],
)
class $AppRouter {}
