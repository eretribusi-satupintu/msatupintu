import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:satupintu_app/model/subwilayah_model.dart';
import 'package:satupintu_app/services/auth_services.dart';
import 'package:http/http.dart' as http;
import 'package:satupintu_app/shared/values.dart';

class SubWilayahService {
  Future<List<SubWilayahModel>> getSubWilayah() async {
    try {
      final token = await AuthService().getToken();
      final roleId = await AuthService().getRoleId();

      final res = await http
          .get(Uri.parse('$baseUrl/sub-wilayah/petugas/$roleId'), headers: {
        'Content-Type': 'application/json',
        'Authorization': token
      });

      if (res.statusCode != 200) {
        throw jsonDecode(res.body)['data'];
      }

      return List<SubWilayahModel>.from(jsonDecode(res.body)['data']
          .map((subwilayah) => SubWilayahModel.fromJson(subwilayah))).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> storeSubwilayahToLocalStorage(SubWilayahModel subWilayah) async {
    try {
      const storage = FlutterSecureStorage();
      await storage.write(key: 'id', value: subWilayah.id.toString());
      await storage.write(key: 'name', value: subWilayah.name);
    } catch (e) {
      rethrow;
    }
  }

  Future<SubWilayahModel> getSubwilayahFromLocalStorage() async {
    try {
      const storage = FlutterSecureStorage();
      Map<String, String> values = await storage.readAll();

      if (values['id'] == null || values['name'] == null) {
        throw 'Tidak dapat mengidentifikasi petugas';
      } else {
        final SubWilayahModel data = SubWilayahModel(
          id: int.parse(values['id']!),
          name: values['name'],
        );

        return data;
      }
    } catch (e) {
      rethrow;
    }
  }
}
