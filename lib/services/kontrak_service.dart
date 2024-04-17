import 'dart:convert';

import 'package:satupintu_app/model/kontrak_item_retribusi_model.dart';
import 'package:satupintu_app/services/auth_services.dart';
import 'package:http/http.dart' as http;
import 'package:satupintu_app/shared/values.dart';

class KontrakService {
  Future<List<KontrakItemRetribusiModel>> getWajibRetribusiKontrak() async {
    try {
      final token = await AuthService().getToken();
      final roleId = await AuthService().getRoleId();
      final res = await http
          .get(Uri.parse('$baseUrl/kontrak/wajib-retribusi/$roleId'), headers: {
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

  Future<KontrakItemRetribusiModel> getKontrakDetail(int kontrakId) async {
    try {
      final token = await AuthService().getToken();

      final res = await http.get(Uri.parse('$baseUrl/kontrak/$kontrakId'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': token
          });

      if (res.statusCode != 200) {
        throw jsonDecode(res.body)['message'];
      }
      return KontrakItemRetribusiModel.fromJson(jsonDecode(res.body)['data']);
    } catch (e) {
      rethrow;
    }
  }

  Future<KontrakItemRetribusiModel> updateKontrakStatus(
      int kontrakId, String status) async {
    try {
      final token = await AuthService().getToken();
      final body = {"status": status};
      print(kontrakId);
      final res = await http.put(
        Uri.parse('$baseUrl/kontrak/$kontrakId/status'),
        headers: {'Content-Type': 'application/json', 'Authorization': token},
        body: jsonEncode(body),
      );

      if (res.statusCode != 200) {
        throw jsonDecode(res.body)['message'];
      }
      return KontrakItemRetribusiModel.fromJson(jsonDecode(res.body)['data']);
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
