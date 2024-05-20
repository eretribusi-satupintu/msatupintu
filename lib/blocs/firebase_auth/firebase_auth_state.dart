part of 'firebase_auth_bloc.dart';

sealed class FirebaseAuthState extends Equatable {
  const FirebaseAuthState();

  @override
  List<Object> get props => [];
}

final class FirebaseAuthInitial extends FirebaseAuthState {}

final class PhoneNumberVerifyLoading extends FirebaseAuthState {}

final class PhoneAuthFailed extends FirebaseAuthState {
  final String e;
  const PhoneAuthFailed(this.e);
}

final class PhoneAuthCodeSentSuccess extends FirebaseAuthState {
  final String verificationId;
  const PhoneAuthCodeSentSuccess(this.verificationId);
}

final class PhoneAuthSuccess extends FirebaseAuthState {
  final String phoneNumber;
  const PhoneAuthSuccess(this.phoneNumber);
}
