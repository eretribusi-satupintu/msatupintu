import 'dart:convert';

import 'package:satupintu_app/model/pembayaran_model.dart';
import 'package:http/http.dart' as http;
import 'package:satupintu_app/services/auth_services.dart';
import 'package:satupintu_app/shared/values.dart';

class PembayaranService {
  Future<List<PembayaranModel>> getPembayaran(String status) async {
    try {
      final token = await AuthService().getToken();
      final res = await http.get(Uri.parse('$baseUrl/pembayaran/$status'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': token
          });

      if (res.statusCode != 200) {
        throw jsonDecode(res.body)['message'];
      }

      return List<PembayaranModel>.from(
        jsonDecode(res.body)['data'].map(
          (pembayaran) => PembayaranModel.fromJson(pembayaran),
        ),
      ).toList();
    } catch (e) {
      rethrow;
    }
  }
}
