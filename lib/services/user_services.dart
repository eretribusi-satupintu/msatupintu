import 'dart:convert';

import 'package:satupintu_app/model/user_auth_model.dart';
import 'package:satupintu_app/model/user_model.dart';
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
}
