

import 'package:flutter_bloc/flutter_bloc.dart';

part 'filter_state.dart';

class FilterCubit extends Cubit<FilterState> {
  FilterCubit(int index) : super(FilterState(typeIndex: index));

  onChangeType(int index){
    emit(FilterState(typeIndex: index));
  }

}
