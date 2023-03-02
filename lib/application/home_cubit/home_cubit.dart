import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState(type: '', distance: ''));

  changeType(String type) {
    emit(state.copyWith(type: type));
  }

  refresh() {
    emit(state.copyWith());
  }

  changeDis(String dis) {
    emit(state.copyWith(distance: dis));
  }
}
