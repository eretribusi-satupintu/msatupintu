import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:satupintu_app/model/login_form_model.dart';
import 'package:satupintu_app/model/user_model.dart';
import 'package:satupintu_app/shared/values.dart';

class AuthService {
  Future<UserModel> login(LoginFormModel data) async {
    // print(data.toJson());
    try {
      final res = await http.post(
        Uri.parse('$baseUrl/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );

      if (res.statusCode == 200) {
        UserModel user = UserModel.fromJson(jsonDecode(res.body)['data']);
        user = user.copyWith(password: data.password);

        await storeCredentialToLocal(user);
        return user;
      } else {
        throw jsonDecode(res.body)['message'];
      }
    } catch (e) {
      print({"error": e});
      rethrow;
    }
  }

  Future<void> storeCredentialToLocal(UserModel user) async {
    try {
      const storage = FlutterSecureStorage();
      await storage.write(key: 'email', value: user.email);
      await storage.write(key: 'password', value: user.password);
      await storage.write(key: 'token', value: user.token);
      await storage.write(key: 'role_id', value: user.roleId.toString());
      if (user.nik != null) {
        await storage.write(key: 'nik', value: user.nik.toString());
      }
      if (user.role == 2) {
        await storage.write(
            key: 'subwilayah_id', value: user.subWilayahId.toString());
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<LoginFormModel> getCredentialFromLocal() async {
    try {
      const storage = FlutterSecureStorage();
      Map<String, String> values = await storage.readAll();

      if (values['email'] == null || values['password'] == null) {
        throw 'authenticated';
      } else {
        final LoginFormModel data = LoginFormModel(
          email: values['email'],
          password: values['password'],
        );

        return data;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<String> getToken() async {
    String? token = '';
    const storage = FlutterSecureStorage();
    String? value = await storage.read(key: 'token');

    if (value != null) {
      token = 'Bearer $value';
    }

    return token;
  }

  Future<String> getRoleId() async {
    String? roleId = '';
    const storage = FlutterSecureStorage();
    String? value = await storage.read(key: 'role_id');

    if (value != null) {
      roleId = value;
    }

    return roleId;
  }

  Future<void> clearLocalStorage() async {
    const storage = FlutterSecureStorage();
    await storage.deleteAll();
  }

  Future<void> logout() async {
    try {
      final token = await AuthService().getToken();

      final res = await http.post(
        Uri.parse('$baseUrl/auth/logout'),
        headers: {'Content-Type': 'application/json', 'Authorization': token},
      );

      if (res.statusCode != 200) {
        throw jsonDecode(res.body)['message'];
      }

      await clearLocalStorage();
      return jsonDecode(res.body)['messagea'];
    } catch (e) {
      rethrow;
    }
  }
}
