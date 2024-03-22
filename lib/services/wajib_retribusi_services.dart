import 'dart:convert';

import 'package:satupintu_app/model/wajib_retribusi_model.dart';
import 'package:satupintu_app/services/auth_services.dart';
import 'package:http/http.dart' as http;
import 'package:satupintu_app/shared/values.dart';

class WajibRetribusiService {
  Future<List<WajibRetribusiModel>> getWajibRetribusi(
      int petugasId, int subWilayahId) async {
    try {
      final token = await AuthService().getToken();
      final res = await http.get(
          Uri.parse(
              '$baseUrl/petugas/$petugasId/wilayah/$subWilayahId/wajib-retribusi'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': token
          });

      if (res.statusCode != 200) {
        throw jsonDecode(res.body)['data'];
      }

      return List<WajibRetribusiModel>.from(jsonDecode(res.body)['data'].map(
              (wajibRetribusi) => WajibRetribusiModel.fromJson(wajibRetribusi)))
          .toList();
    } catch (e) {
      rethrow;
    }
  }
}
