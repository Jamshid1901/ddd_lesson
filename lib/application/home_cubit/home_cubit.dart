

import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState(typeIndex: -1));

  onChangeType(int index){
    emit(HomeState(typeIndex: index));
  }

}
