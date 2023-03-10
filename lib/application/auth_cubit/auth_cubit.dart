import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthState());

  // login(String phone, String password, VoidCallback onSuccess) async {
  //   emit(state.copyWith(isLoading: true));
  //   try {
  //     var res = await firestore
  //         .collection("users")
  //         .where("phone", isEqualTo: phone)
  //         .get();
  //     if (res.docs.first["password"] == password) {
  //       LocalStore.setDocId(res.docs.first.id);
  //       onSuccess();
  //       emit(state.copyWith(isLoading: false));
  //     } else {
  //       emit(state.copyWith(isLoading: false));
  //     }
  //   } catch (e) {
  //     emit(state.copyWith(isLoading: false));
  //   }
  // }
}
