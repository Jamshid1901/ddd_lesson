import 'package:ddd_lesson/application/home_cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class AppHelper {
  AppHelper._();

  static showCustomDialog({required BuildContext context,
    required String title,
    required ValueChanged<int> onSelect,
    required List list}) {
    showDialog(
        context: context,
        builder: (con) {
          return BlocProvider(
            create: (context) => HomeCubit(),
            child: AlertDialog(
              title: Text(title),
              content: SizedBox(
                height: 200,
                width: 200,
                child: ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                           context.read<HomeCubit>().onChangeType(index);
                          },
                          child: BlocBuilder<HomeCubit, HomeState>(
                            builder: (context, state) {
                              return Row(
                                children: [
                                  index == state.typeIndex
                                      ? Icon(Icons.circle)
                                      : Icon(Icons.circle_outlined),
                                  Text(
                                    list[index],
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      );
                    }),
              ),
            ),
          );
        });
  }
}
