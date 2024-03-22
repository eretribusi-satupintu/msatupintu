import 'dart:convert';

import 'package:satupintu_app/model/kontrak_item_retribusi_model.dart';
import 'package:satupintu_app/services/auth_services.dart';
import 'package:http/http.dart' as http;
import 'package:satupintu_app/shared/values.dart';

class ItemRetribusiService {
  Future<List<KontrakItemRetribusiModel>> getItemRetribusiSewa(
      int retribusiId) async {
    try {
      final token = await AuthService().getToken();
      final roleId = await AuthService().getRoleId();
      final res = await http.get(
          Uri.parse(
              '$baseUrl/retribusi/get/wajib-retribusi/$roleId/item-retribusi/$retribusiId'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': token,
          });

      if (res.statusCode != 200) {
        throw jsonDecode(res.body)['message'];
      }

      return List<KontrakItemRetribusiModel>.from(
        jsonDecode(res.body)['data'].map(
          (retribusi) => KontrakItemRetribusiModel.fromJson(retribusi),
        ),
      ).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<KontrakItemRetribusiModel>> getKontrakWajibRetribusi(
      int wajibRetribusiId, int subWilayahId) async {
    try {
      final token = await AuthService().getToken();
      final res = await http.get(
          Uri.parse(
              '$baseUrl/petugas/$wajibRetribusiId/wilayah/$subWilayahId/kontrak'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': token
          });

      if (res.statusCode != 200) {
        throw jsonDecode(res.body)['data'];
      }

      return List<KontrakItemRetribusiModel>.from(jsonDecode(res.body)['data']
          .map((wajibRetribusi) =>
              KontrakItemRetribusiModel.fromJson(wajibRetribusi))).toList();
    } catch (e) {
      rethrow;
    }
  }
}
