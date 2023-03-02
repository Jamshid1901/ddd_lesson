part of 'filter_cubit.dart';

class FilterState {
  int typeIndex;
  List? listOfRoom;

  FilterState({required this.typeIndex, this.listOfRoom});

  FilterState copyWith({int? typeIndex, List? list}) {
    return FilterState(
        typeIndex: typeIndex ?? this.typeIndex, listOfRoom: list ?? listOfRoom);
  }
}
