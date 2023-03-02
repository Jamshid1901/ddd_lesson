part of 'home_cubit.dart';

class HomeState {
  String type;
  String distance;

  HomeState({required this.type, required this.distance});

  HomeState copyWith({String? type, String? distance}) {
    return HomeState(
        type: type ?? this.type, distance: distance ?? this.distance);
  }
}
