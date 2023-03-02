import 'package:ddd_lesson/application/filter_cubit/filter_cubit.dart';
import 'package:ddd_lesson/domain/model/room_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class AppHelper {
  AppHelper._();

  static showCustomDialog(
      {required BuildContext context,
      required String title,
      required int initIndex,
      required ValueChanged<int> onSelect,
      required ValueChanged<List?> onSelectList,
      required List list,
      bool multiSelected = false}) {
    showDialog(
        context: context,
        builder: (con) {
          return BlocProvider(
            create: (context) => FilterCubit(initIndex, list: list),
            child: AlertDialog(
              title: Text(title),
              content: SizedBox(
                height: 200,
                width: 200,
                child: !multiSelected
                    ? ListView.builder(
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
                        })
                    : BlocBuilder<FilterCubit, FilterState>(
                        builder: (context, state) {
                          return ListView.builder(
                              itemCount: state.listOfRoom?.length ?? 0,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () {
                                      context
                                          .read<FilterCubit>()
                                          .onChangeList(index);
                                    },
                                    child:
                                        BlocBuilder<FilterCubit, FilterState>(
                                      builder: (context, state) {
                                        return Row(
                                          children: [
                                            (state.listOfRoom?[index] as Room)
                                                    .isActive
                                                ? const Icon(Icons.circle)
                                                : const Icon(
                                                    Icons.circle_outlined),
                                            Text(
                                              (state.listOfRoom?[index] as Room)
                                                  .title,
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                );
                              });
                        },
                      ),
              ),
              actions: [
                BlocBuilder<FilterCubit, FilterState>(
                  builder: (context, state) {
                    return ElevatedButton(
                        onPressed: () {
                          !multiSelected ?
                          onSelect(state.typeIndex) :
                          onSelectList(state.listOfRoom);
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
