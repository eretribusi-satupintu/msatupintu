import 'dart:convert';

import 'package:satupintu_app/model/tagihan_model.dart';
import 'package:satupintu_app/services/auth_services.dart';
import 'package:http/http.dart' as http;
import 'package:satupintu_app/shared/values.dart';

class TagihanService {
  Future<List<TagihanModel>> getNewestTagihan() async {
    try {
      final token = await AuthService().getToken();
      final roleId = await AuthService().getRoleId();

      final res = await http.get(Uri.parse('$baseUrl/tagihan/$roleId'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': token
          });

      if (res.statusCode != 200) {
        throw jsonDecode(res.body)['message'];
      }
      return List<TagihanModel>.from(jsonDecode(res.body)['data'].map(
        (tagihan) => TagihanModel.fromJson(tagihan),
      )).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<TagihanModel>> getRetribusiTagihan(int itemRetribusiId) async {
    try {
      final token = await AuthService().getToken();
      final roleId = await AuthService().getRoleId();

      final res = await http.get(
          Uri.parse('$baseUrl/tagihan/$roleId/item-retribusi/$itemRetribusiId'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': token
          });

      if (res.statusCode != 200) {
        throw jsonDecode(res.body)['message'];
      }

      return List<TagihanModel>.from(jsonDecode(res.body)['data']
          .map((tagihan) => TagihanModel.fromJson(tagihan))).toList();
    } catch (e) {
      rethrow;
    }
  }
}
