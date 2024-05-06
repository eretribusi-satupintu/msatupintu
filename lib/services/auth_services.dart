import 'dart:convert';

import 'package:satupintu_app/blocs/tagihan_local/tagihan_local_bloc.dart';
import 'package:satupintu_app/db/database.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:satupintu_app/model/login_form_model.dart';
import 'package:satupintu_app/model/user_auth_model.dart';
import 'package:satupintu_app/services/tagihan_local_services.dart';
import 'package:satupintu_app/shared/values.dart';

class AuthService {
  Future<UserAuthModel> login(LoginFormModel data) async {
    // print(data.toJson());
    try {
      final res = await http.post(
        Uri.parse('$baseUrl/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );

      if (res.statusCode == 200) {
        UserAuthModel user =
            UserAuthModel.fromJson(jsonDecode(res.body)['data']);
        user = user.copyWith(password: data.password);

        await storeCredentialToLocal(user);
        return user;
      } else {
        throw jsonDecode(res.body)['message'];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> storeCredentialToLocal(UserAuthModel user) async {
    try {
      const storage = FlutterSecureStorage();
      await storage.write(key: 'email', value: user.email);
      await storage.write(key: 'password', value: user.password);
      await storage.write(key: 'token', value: user.token);
      await storage.write(key: 'role', value: user.role.toString());
      await storage.write(key: 'role_id', value: user.roleId.toString());
      if (user.nik != null) {
        await storage.write(key: 'nik', value: user.nik.toString());
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
          role: int.parse(values['role']!),
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
      final res = await http.post(
        Uri.parse('$baseUrl/auth/logout'),
        headers: {'Content-Type': 'application/json'},
      );

      if (res.statusCode != 200) {
        throw jsonDecode(res.body)['message'];
      }

      await clearLocalStorage();
      await TagihanLocalServices().deleteAllTagihan();
      return jsonDecode(res.body)['message'];
    } catch (e) {
      rethrow;
    }
  }
}
