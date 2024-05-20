import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:satupintu_app/services/user_services.dart';

part 'firebase_auth_event.dart';
part 'firebase_auth_state.dart';

class FirebaseAuthBloc extends Bloc<FirebaseAuthEvent, FirebaseAuthState> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  FirebaseAuthBloc(super.initialState) {
    on<SendOtpPhoneEvent>((event, emit) {
      emit(PhoneNumberVerifyLoading());
      try {
        // final isExist = await UserServices().checkPhoneNumberIsExist(event.number);
        firebaseAuth.verifyPhoneNumber(
          phoneNumber: event.number,
          verificationCompleted: (PhoneAuthCredential credential) {
            add(PhoneAuthVerificationCompletedEvent(credential, event.number));
          },
          verificationFailed: (FirebaseAuthException e) {
            if (e.code == 'invalid-phone-number') {
              add(const PhoneAuthErrorEvent(
                  "The provided phone number is not valid."));
            }
            add(PhoneAuthErrorEvent(e.toString()));
          },
          codeSent: (String verificationId, int? refreshToken) {
            add(PhoneOtpSend(verificationId, refreshToken));
          },
          codeAutoRetrievalTimeout: (String verificationId) {},
        );
      } catch (e) {
        emit(PhoneAuthFailed(e.toString()));
      }
    });

    on<PhoneOtpSend>((event, emit) {
      emit(PhoneAuthCodeSentSuccess(event.verificationId));
    });

    on<VerifySentOtp>((event, emit) {
      try {
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
            verificationId: event.verificationId, smsCode: event.otpCode);

        add(PhoneAuthVerificationCompletedEvent(credential, event.phoneNumber));
      } catch (e) {
        emit(PhoneAuthFailed(e.toString()));
      }
    });

    on<PhoneAuthErrorEvent>((event, emit) {
      emit(PhoneAuthFailed(event.error.toString()));
    });

    on<PhoneAuthVerificationCompletedEvent>((event, emit) async {
      try {
        emit(PhoneNumberVerifyLoading());
        await firebaseAuth.signInWithCredential(event.credential).then((value) {
          emit(PhoneAuthSuccess(event.phoneNumber));
        });
        emit(FirebaseAuthInitial());
      } catch (e) {
        if (e is FirebaseAuthException) {
          if (e.code == 'invalid-verification-code') {
            emit(const PhoneAuthFailed("Kode OTP anda salah"));
          } else {
            emit(PhoneAuthFailed(e.message.toString()));
          }
        } else {
          emit(PhoneAuthFailed(e.toString()));
        }
      }
    });
  }
}
