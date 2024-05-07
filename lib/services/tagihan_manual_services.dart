import 'dart:convert';

import 'package:satupintu_app/model/tagihan_manual_form_model.dart';
import 'package:satupintu_app/model/tagihan_manual_model.dart';
import 'package:satupintu_app/services/auth_services.dart';
import 'package:satupintu_app/services/subwilayah_services.dart';
import 'package:http/http.dart' as http;
import 'package:satupintu_app/shared/values.dart';

class TagihanManualServices {
  Future<List<TagihanManualModel>> getTagihanManual() async {
    try {
      final token = await AuthService().getToken();
      final roleId = await AuthService().getRoleId();
      final subWilayah =
          await SubWilayahService().getSubwilayahFromLocalStorage();

      final res = await http.get(
          Uri.parse(
              '$baseUrl/tagihan-manual/petugas/$roleId/subwilayah/${subWilayah.id}'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': token
          });

      if (res.statusCode != 200) {
        throw jsonDecode(res.body)['message'];
      }

      return List<TagihanManualModel>.from(jsonDecode(res.body)['data']
          .map((tagihan) => TagihanManualModel.fromJson(tagihan))).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<TagihanManualModel>> getPaidTagihanManual() async {
    try {
      final token = await AuthService().getToken();
      final roleId = await AuthService().getRoleId();
      final subWilayah =
          await SubWilayahService().getSubwilayahFromLocalStorage();

      final res = await http.get(
          Uri.parse(
              '$baseUrl/tagihan-manual/petugas/$roleId/subwilayah/${subWilayah.id}/paid'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': token
          });

      if (res.statusCode != 200) {
        throw jsonDecode(res.body)['message'];
      }

      return List<TagihanManualModel>.from(jsonDecode(res.body)['data']
          .map((tagihan) => TagihanManualModel.fromJson(tagihan))).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<TagihanManualModel> postTagihanManual(
      TagihanManualFormModel tagihanManual) async {
    try {
      final token = await AuthService().getToken();
      final roleId = await AuthService().getRoleId();
      final subWilayah =
          await SubWilayahService().getSubwilayahFromLocalStorage();

      final body = {
        "item_retribusi_id": tagihanManual.itemRetribusiId,
        "detail_tagihan": tagihanManual.detailTagihan,
        "total_harga": tagihanManual.price,
      };

      final res = await http.post(
        Uri.parse(
            '$baseUrl/tagihan-manual/petugas/$roleId/subwilayah/${subWilayah.id}'),
        headers: {'Content-Type': 'application/json', 'Authorization': token},
        body: jsonEncode(body),
      );

      if (res.statusCode != 200) {
        throw jsonDecode(res.body)['message'];
      }

      return TagihanManualModel.fromJson(jsonDecode(res.body)['data']);
    } catch (e) {
      rethrow;
    }
  }
}
