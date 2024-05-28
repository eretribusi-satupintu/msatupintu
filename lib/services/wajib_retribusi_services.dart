import 'dart:convert';

import 'package:satupintu_app/model/wajib_retribusi_model.dart';
import 'package:satupintu_app/services/auth_services.dart';
import 'package:http/http.dart' as http;
import 'package:satupintu_app/services/subwilayah_services.dart';
import 'package:satupintu_app/shared/values.dart';

class WajibRetribusiService {
  Future<List<WajibRetribusiModel>> getWajibRetribusi() async {
    try {
      final token = await AuthService().getToken();
      final subWilayah =
          await SubWilayahService().getSubwilayahFromLocalStorage();
      final res = await http.get(
          Uri.parse('$baseUrl/wajib-retribusi/wilayah/${subWilayah.id}'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': token
          });

      if (res.statusCode != 200) {
        throw jsonDecode(res.body)['message'];
      }

      return List<WajibRetribusiModel>.from(jsonDecode(res.body)['data'].map(
              (wajibRetribusi) => WajibRetribusiModel.fromJson(wajibRetribusi)))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<WajibRetribusiModel>> getWajibRetribusiByWrName(
      String name) async {
    try {
      final token = await AuthService().getToken();
      final subWilayah =
          await SubWilayahService().getSubwilayahFromLocalStorage();
      final res = await http.get(
          Uri.parse('$baseUrl/wajib-retribusi/wilayah/${subWilayah.id}'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': token
          });

      if (res.statusCode != 200) {
        throw jsonDecode(res.body)['message'];
      }

      return List<WajibRetribusiModel>.from(jsonDecode(res.body)['data'].map(
              (wajibRetribusi) => WajibRetribusiModel.fromJson(wajibRetribusi)))
          .where((wajibRetribusi) =>
              wajibRetribusi.name!.toLowerCase().contains(name.toLowerCase()))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<WajibRetribusiModel> getWajibRetribusiDetail(
      int wajibRetribusiId) async {
    try {
      final token = await AuthService().getToken();
      final subWilayah =
          await SubWilayahService().getSubwilayahFromLocalStorage();
      final res = await http.get(
          Uri.parse(
              '$baseUrl/wajib-retribusi/$wajibRetribusiId/sub-wilayah/${subWilayah.id}'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': token
          });

      if (res.statusCode != 200) {
        throw jsonDecode(res.body)['message'];
      }

      return WajibRetribusiModel.fromJson(jsonDecode(res.body)['data']);
    } catch (e) {
      rethrow;
    }
  }
}
