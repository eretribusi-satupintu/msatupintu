import 'dart:convert';

import 'package:satupintu_app/model/tagihan_model.dart';
import 'package:satupintu_app/model/transaksi_petugas_model.dart';
import 'package:satupintu_app/services/auth_services.dart';
import 'package:http/http.dart' as http;
import 'package:satupintu_app/services/tagihan_local_services.dart';
import 'package:satupintu_app/shared/values.dart';

class TransaksiPetugas {
  Future<TagihanModel> petugasPaidTagihan(
      int tagihanId, String paymentMethod, String? paymentImage) async {
    try {
      final token = await AuthService().getToken();
      final petugasId = await AuthService().getRoleId();
      final body = {
        "petugas_id": int.parse(petugasId),
        "tagihan_id": tagihanId,
        "metode_pembayaran": paymentMethod,
        "bukti_bayar": paymentImage ?? ""
      };

      final res = await http.post(
        Uri.parse('$baseUrl/transaksi-petugas/pay/cash'),
        headers: {'Content-Type': 'application/json', 'Authorization': token},
        body: jsonEncode(body),
      );

      if (res.statusCode != 200) {
        throw jsonDecode(res.body)['message'];
      }

      TagihanLocalServices().deleteTagihan(tagihanId);

      return TagihanModel.fromJson(jsonDecode(res.body)['data']);
    } catch (e) {
      rethrow;
    }
  }

  Future<TagihanModel> petugasPaidTagihanCancel(int tagihanId) async {
    try {
      final token = await AuthService().getToken();
      final body = {
        "tagihan_id": tagihanId,
      };

      final res = await http.post(
        Uri.parse('$baseUrl/transaksi-petugas/pay/cash/cancel'),
        headers: {'Content-Type': 'application/json', 'Authorization': token},
        body: jsonEncode(body),
      );

      if (res.statusCode != 200) {
        throw jsonDecode(res.body)['message'];
      }
      return TagihanModel.fromJson(jsonDecode(res.body)['data']);
    } catch (e) {
      rethrow;
    }
  }
}
