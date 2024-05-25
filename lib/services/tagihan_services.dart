import 'dart:convert';

import 'package:satupintu_app/model/tagihan_local_model.dart';
import 'package:satupintu_app/model/tagihan_model.dart';
import 'package:satupintu_app/services/auth_services.dart';
import 'package:http/http.dart' as http;
import 'package:satupintu_app/services/subwilayah_services.dart';
import 'package:satupintu_app/shared/values.dart';

class TagihanService {
  Future<List<TagihanModel>> getNewestTagihan() async {
    try {
      final token = await AuthService().getToken();
      final roleId = await AuthService().getRoleId();

      final res = await http.get(
          Uri.parse('$baseUrl/tagihan/wajib_retribusi/$roleId/newest'),
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

  Future<List<TagihanModel>> getTagihanWajibRetribusi(
      int wajibRetribusiId) async {
    try {
      final token = await AuthService().getToken();
      final subWilayah =
          await SubWilayahService().getSubwilayahFromLocalStorage();

      final res = await http.get(
          Uri.parse(
              '$baseUrl/tagihan/wajib-retribusi/$wajibRetribusiId/sub-wilayah/${subWilayah.id}'),
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

  Future<List<TagihanModel>> getTagihanWajibRetribusiMasyarakat() async {
    try {
      final token = await AuthService().getToken();
      final wajibRetribusiId = await AuthService().getRoleId();
      print({"wr_id": wajibRetribusiId});
      final res = await http.get(
          Uri.parse('$baseUrl/tagihan/wajib-retribusi/$wajibRetribusiId'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': token
          });

      if (res.statusCode != 200) {
        throw jsonDecode(res.body)['message'];
      }

      print(jsonDecode(res.body)['data']);

      return List<TagihanModel>.from(jsonDecode(res.body)['data']
          .map((tagihan) => TagihanModel.fromJson(tagihan))).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<TagihanModel>> getTagihanWajibRetribusiMasyarakatbyTagihanName(
      String tagihanName) async {
    try {
      final token = await AuthService().getToken();
      final wajibRetribusiId = await AuthService().getRoleId();
      // print({"wr_id": wajibRetribusiId});
      final res = await http.get(
          Uri.parse('$baseUrl/tagihan/wajib-retribusi/$wajibRetribusiId'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': token
          });

      if (res.statusCode != 200) {
        throw jsonDecode(res.body)['message'];
      }

      // print(jsonDecode(res.body)['data']);

      return List<TagihanModel>.from(jsonDecode(res.body)['data']
              .map((tagihan) => TagihanModel.fromJson(tagihan)))
          .where((tagihan) => tagihan.tagihanName!
              .toLowerCase()
              .contains(tagihanName.toLowerCase()))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<TagihanModel>> getTagihanWajibRetribusiMasyarakatProgress(
      int kontrakId) async {
    try {
      final token = await AuthService().getToken();
      final wajibRetribusiId = await AuthService().getRoleId();

      final res = await http.get(
          Uri.parse(
              '$baseUrl/tagihan/wajib-retribusi/$wajibRetribusiId/kontrak/$kontrakId/progress'),
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

  Future<List<TagihanModel>> getRetribusiTagihan(int itemRetribusiId) async {
    try {
      final token = await AuthService().getToken();
      final subWilayah =
          await SubWilayahService().getSubwilayahFromLocalStorage();

      final res = await http.get(
          Uri.parse(
              '$baseUrl/tagihan/${subWilayah.id}/item-retribusi/$itemRetribusiId'),
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

  Future<List<TagihanModel>> getPetugasPaidTagihan(String status) async {
    try {
      final token = await AuthService().getToken();
      final roleId = await AuthService().getRoleId();
      final subWilayah =
          await SubWilayahService().getSubwilayahFromLocalStorage();

      final res = await http.get(
          Uri.parse(
              '$baseUrl/tagihan/petugas/$roleId/sub-wilayah/${subWilayah.id}/status/$status'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': token
          });

      if (res.statusCode != 200) {
        throw jsonDecode(res.body)['data'];
      }

      return List<TagihanModel>.from(jsonDecode(res.body)['data']
          .map((tagihan) => TagihanModel.fromJson(tagihan))).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<TagihanModel>> getPetugasAllPaidTagihan() async {
    try {
      final token = await AuthService().getToken();
      final roleId = await AuthService().getRoleId();
      final subWilayah =
          await SubWilayahService().getSubwilayahFromLocalStorage();

      final res = await http.get(
          Uri.parse(
              '$baseUrl/tagihan/petugas/$roleId/sub-wilayah/${subWilayah.id}/all'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': token
          });

      if (res.statusCode != 200) {
        throw jsonDecode(res.body)['data'];
      }

      return List<TagihanModel>.from(jsonDecode(res.body)['data']
          .map((tagihan) => TagihanModel.fromJson(tagihan))).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<TagihanModel> getTagihanDetail(int tagihanId) async {
    try {
      final token = await AuthService().getToken();

      final res = await http.get(Uri.parse('$baseUrl/tagihan/$tagihanId'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': token
          });

      if (res.statusCode != 200) {
        throw jsonDecode(res.body)['message'];
      }

      return TagihanModel.fromJson(jsonDecode(res.body)['data']);
    } catch (e) {
      rethrow;
    }
  }
}
