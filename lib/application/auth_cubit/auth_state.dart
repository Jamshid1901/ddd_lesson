part of 'auth_cubit.dart';

@immutable
class AuthState {
  String? verificationId;
  String? phone;
  String? errorText;
  String? imagePath;
  bool? isLoading;
  bool? isGoogleLoading;
  bool? isFacebookLoading;

  AuthState({String phone = '', bool isLoading = false});

  AuthState copyWith({String? phone, bool? isLoading}) {
    return AuthState(
        phone: phone ?? this.phone ?? "",
        isLoading: isLoading ?? this.isLoading ?? false);
  }
}
