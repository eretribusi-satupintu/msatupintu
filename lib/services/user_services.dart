import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:satupintu_app/model/user_auth_model.dart';
import 'package:satupintu_app/model/user_model.dart';
import 'package:satupintu_app/model/user_update_form_model.dart';
import 'package:satupintu_app/services/auth_services.dart';
import 'package:http/http.dart' as http;
import 'package:satupintu_app/shared/values.dart';

class UserServices {
  Future<UserModel> getUser() async {
    try {
      final token = await AuthService().getToken();
      final user = await AuthService().getCredentialFromLocal();
      final body = {"email": user.email};

      final res = await http.post(Uri.parse('$baseUrl/user'),
          headers: {
            'content-type': 'application/json',
            'Authorization': token,
          },
          body: jsonEncode(body));

      if (res.statusCode != 200) {
        throw jsonDecode(res.body)['message'];
      }

      return UserModel.fromJson(jsonDecode(res.body)['data']);
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> updateUser(int userId, UserUpdateFormModel user) async {
    try {
      final token = await AuthService().getToken();
      final body = {
        "email": user.email,
        "alamat": user.address,
        "phone_number": user.phoneNumber,
        "photo_profile": user.photoProfile
      };

      final res = await http.put(Uri.parse('$baseUrl/user/$userId'),
          headers: {
            'content-type': 'application/json',
            'Authorization': token,
          },
          body: jsonEncode(body));

      if (res.statusCode != 200) {
        throw jsonDecode(res.body)['message'];
      }

      const storage = FlutterSecureStorage();
      await storage.write(key: 'email', value: user.email);

      return UserModel.fromJson(jsonDecode(res.body)['data']);
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> updatePassword(String oldPassword, String newPassword,
      String confirmationPassword) async {
    try {
      final token = await AuthService().getToken();
      final user = await AuthService().getCredentialFromLocal();
      final body = {
        "email": user.email,
        "old_password": oldPassword,
        "new_password": newPassword,
        "confirmation_password": confirmationPassword
      };
      print(jsonEncode(body));
      final res = await http.post(Uri.parse('$baseUrl/user/update-password'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': token,
          },
          body: jsonEncode(body));

      if (res.statusCode != 200) {
        print(jsonDecode(res.body)['message']);
        throw jsonDecode(res.body)['message'];
      }

      return true;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<bool> updateForgotPassword(String phoneNumber, String newPassword,
      String confirmationPassword) async {
    try {
      final body = {
        "new_password": newPassword,
        "confirmation_password": confirmationPassword
      };

      if (await checkPhoneNumberIsExist(phoneNumber) == false) {
        throw "No handphone tidak terdaftar";
      }

      print("body: $newPassword $confirmationPassword");
      final res = await http.post(
          Uri.parse('$baseUrl/forgot-password/$phoneNumber/update'),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode(body));

      if (res.statusCode != 200) {
        throw jsonDecode(res.body)['message'];
      }

      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> checkPhoneNumberIsExist(String phoneNumber) async {
    try {
      final res = await http
          .get(Uri.parse('$baseUrl/forgot-password/$phoneNumber'), headers: {
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

  // Future<String> checkPhoneNumberIsExist(String phoneNumber) async {
  //   try {
  //     final isExist = await UserServices().checkPhoneNumberIsExist(phoneNumber);
  //     if (isExist == true) {
  //       await FirebaseAuth.instance.verifyPhoneNumber(
  //         phoneNumber: '+62${phoneNumber}',
  //         verificationCompleted: (PhoneAuthCredential credential) {},
  //         verificationFailed: (FirebaseAuthException e) {
  //           if (e.code == 'invalid-phone-number') {
  //             return "No handphone tidak sesuai";
  //           } else {
  //             emit(FirebaseOtpFailed(e.toString()));
  //             return;
  //           }
  //         },
  //         codeSent: (String verificationId, int? resendToken) {
  //           // log(verificationId);
  //           isVerificationId = verificationId;
  //           emit(FirebaseGetOtpSuccess(verificationId));
  //           return;
  //         },
  //         codeAutoRetrievalTimeout: (String verificationId) {
  //           emit(const FirebaseOtpFailed('Waktu habis'));
  //           return;
  //         },
  //       );
  //     } else {
  //       emit(const FirebaseOtpFailed("No Handphone tidak tersedia"));
  //       return;
  //     }

  //     return jsonDecode(res.body)['data']['is_exist'];
  //   } catch (e) {
  //     rethrow;
  //   }
  // }
}
