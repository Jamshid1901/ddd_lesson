import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/model/room_model.dart';

part 'filter_state.dart';

class FilterCubit extends Cubit<FilterState> {
  FilterCubit(int index, {List? list})
      : super(FilterState(typeIndex: index, listOfRoom: list));

  List<Room> listOfRoom =
      List.generate(6, (index) => Room(title: "$index xona"));

  onChangeType(int index) {
    emit(state.copyWith(typeIndex: index, list: listOfRoom));
  }

  onChangeList(int index) {
    (state.listOfRoom?[index] as Room).isActive =
        !(state.listOfRoom?[index] as Room).isActive;
    emit(state.copyWith(list: state.listOfRoom));
  }
}
