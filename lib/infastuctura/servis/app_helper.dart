import 'package:ddd_lesson/application/filter_cubit/filter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class AppHelper {
  AppHelper._();

  static showCustomDialog(
      {required BuildContext context,
      required String title,
      required int initIndex,
      required ValueChanged<int> onSelect,
      required List list}) {
    showDialog(
        context: context,
        builder: (con) {
          return BlocProvider(
            create: (context) => FilterCubit(initIndex),
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
                            context.read<FilterCubit>().onChangeType(index);
                          },
                          child: BlocBuilder<FilterCubit, FilterState>(
                            builder: (context, state) {
                              return Row(
                                children: [
                                  index == state.typeIndex
                                      ? const Icon(Icons.circle)
                                      : const Icon(Icons.circle_outlined),
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
              actions: [
                BlocBuilder<FilterCubit, FilterState>(
                  builder: (context, state) {
                    return ElevatedButton(
                        onPressed: () {
                          onSelect(state.typeIndex);
                          Navigator.pop(context);
                        },
                        child: const Text("Save"));
                  },
                )
              ],
            ),
          );
        });
  }
}
