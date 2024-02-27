import 'dart:convert';

import 'package:satupintu_app/model/tagihan_model.dart';
import 'package:satupintu_app/services/auth_services.dart';
import 'package:http/http.dart' as http;
import 'package:satupintu_app/shared/values.dart';

class TagihanService {
  Future<List<TagihanModel>> getTagihan() async {
    try {
      final token = await AuthService().getToken();

      final res = await http.get(Uri.parse('$baseUrl/tagihan'), headers: {
        'Content-Type': 'application/json',
        'Authorization': token
      });

      if (res.statusCode != 200) {
        throw jsonDecode(res.body)['message'];
      }
      // print(jsonDecode(res.body)['data']);
      return List<TagihanModel>.from(jsonDecode(res.body)['data'].map(
        (tagihan) => TagihanModel.fromJson(tagihan),
      )).toList();
    } catch (e) {
      rethrow;
    }
  }
}
