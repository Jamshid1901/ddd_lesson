import 'package:ddd_lesson/application/home_cubit/home_cubit.dart';
import 'package:ddd_lesson/presentation/pages/no_internet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class Routes {
  Routes._();

  static PageRoute goNoInternet({String? type}) {
    return MaterialPageRoute(
      builder: (_) => BlocProvider(
        create: (context) => HomeCubit()..changeType(type ?? ""),
        child: const NoInternet(),
      ),
    );
  }

  static PageRoute goNoInternetWithoutBloc({String? type}) {
    return MaterialPageRoute(
      builder: (_) => const NoInternet(),
    );
  }
}


