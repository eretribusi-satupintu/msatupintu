import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:satupintu_app/services/auth_services.dart';
import 'package:http/http.dart' as http;
import 'package:satupintu_app/shared/values.dart';

class FireBaseOtpServices {
  String verId = '';

  String getVerificationId() {
    return verId;
  }

  void setVerificationId(String id) {
    verId = id;
  }

  Future<bool> checkPhoneNumberIsExist(String phoneNumber) async {
    try {
      final res = await http
          .get(Uri.parse('$baseUrl/check-phone-number/$phoneNumber'), headers: {
        'Content-Type': 'application/json',
      });

      if (res.statusCode != 200) {
        throw jsonDecode(res.body)['message'];
      }

      return jsonDecode(res.body)['data']['is_exist'];
    } catch (e) {
      rethrow;
    }
  }

  Future<String> getPhoneNumberOtp(String phoneNumber) async {
    try {
      final isExist = await checkPhoneNumberIsExist(phoneNumber);

      if (isExist == true) {
        String getVerificationId = '';
        try {
          await FirebaseAuth.instance.verifyPhoneNumber(
            phoneNumber: '+62$phoneNumber',
            verificationCompleted: (PhoneAuthCredential credential) {},
            verificationFailed: (FirebaseAuthException e) {
              if (e.code == 'invalid-phone-number') {
                throw ("phone format invalid");
              } else {
                throw ("verification failed");
              }
            },
            codeSent: (String verificationId, int? resendToken) {
              // verId = verificationId;
              // getPhoneNumberOtp(verificationId);
              setVerificationId(verificationId);
            },
            codeAutoRetrievalTimeout: (String verificationId) {
              throw ("Waktu habis");
            },
          );
          if (getVerificationId != '') {
            print({"verfication_id": getVerificationId});
            return verId;
          } else {
            throw ("Terjadi Kesalahan");
          }
        } catch (e) {
          rethrow;
        }
      } else {
        throw ("No handphone tidak terdaftar");
      }
    } catch (e) {
      rethrow;
    }
  }
}
