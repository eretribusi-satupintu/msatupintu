part of 'firebase_auth_bloc.dart';

sealed class FirebaseAuthEvent extends Equatable {
  const FirebaseAuthEvent();

  @override
  List<Object> get props => [];
}

class SendOtpPhoneEvent extends FirebaseAuthEvent {
  final String number;
  const SendOtpPhoneEvent(this.number);
}

class PhoneOtpSend extends FirebaseAuthEvent {
  final String verificationId;
  final int? token;
  const PhoneOtpSend(this.verificationId, this.token);
}

class VerifySentOtp extends FirebaseAuthEvent {
  final String phoneNumber;
  final String otpCode;
  final String verificationId;

  const VerifySentOtp(this.otpCode, this.verificationId, this.phoneNumber);
}

class PhoneAuthErrorEvent extends FirebaseAuthEvent {
  final String error;
  const PhoneAuthErrorEvent(this.error);
}

class PhoneAuthVerificationCompletedEvent extends FirebaseAuthEvent {
  final String phoneNumber;
  final AuthCredential credential;
  const PhoneAuthVerificationCompletedEvent(this.credential, this.phoneNumber);
}
