import 'dart:convert';

import 'package:satupintu_app/model/retribusi_model.dart';
import 'package:http/http.dart' as http;
import 'package:satupintu_app/services/auth_services.dart';
import 'package:satupintu_app/shared/values.dart';

class RetribusiServices {
  Future<List<RetribusiModel>> getRetribusi() async {
    try {
      final token = await AuthService().getToken();
      final roleId = await AuthService().getRoleId();

      final res = await http.get(
        Uri.parse('$baseUrl/retribusi/get/wajib-retribusi/$roleId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token,
        },
      );

      if (res.statusCode != 200) {
        throw jsonDecode(res.body)['message'];
      }

      return List<RetribusiModel>.from(
        jsonDecode(res.body)['data'].map(
          (retribusi) => RetribusiModel.fromJson(retribusi),
        ),
      ).toList();
    } catch (e) {
      rethrow;
    }
  }
}
