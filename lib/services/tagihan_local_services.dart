import 'dart:convert';

import 'package:satupintu_app/db/database.dart';
import 'package:satupintu_app/model/tagihan_local_model.dart';
import 'package:satupintu_app/services/auth_services.dart';
import 'package:satupintu_app/services/subwilayah_services.dart';
import 'package:satupintu_app/shared/values.dart';
import 'package:http/http.dart' as http;

class TagihanLocalServices {
  final dbProvider = DatabaseProvider.dbProvider;

  Future<List<TagihanLocalModel>> getTagihan() async {
    try {
      final db = await dbProvider.database;
      List<Map<String, dynamic>> res;
      res = await db.query(tagihanTable);
      List<TagihanLocalModel> tagihan = res.isNotEmpty
          ? res.map((item) => TagihanLocalModel.fromDatabaseJson(item)).toList()
          : [];
      return tagihan;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteTagihan(int id) async {
    try {
      final db = await dbProvider.database;
      db.delete(tagihanTable, where: 'tagihan_id = $id');
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteAllTagihan() async {
    try {
      final db = await dbProvider.database;
      db.rawDelete("DELETE FROM $tagihanTable");
    } catch (e) {
      rethrow;
    }
  }

  Future<int> storeTagihan(TagihanLocalModel tagihan) async {
    try {
      final db = await dbProvider.database;
      final res = db.insert(tagihanTable, tagihan.toDatabaseJson());
      return res;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<TagihanLocalModel>> storeTagihanFromServer() async {
    try {
      final token = await AuthService().getToken();
      final subWilayah =
          await SubWilayahService().getSubwilayahFromLocalStorage();

      final res = await http.get(
          Uri.parse('$baseUrl/tagihan/petugas/sub-wilayah/${subWilayah.id}'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': token
          });

      if (res.statusCode != 200) {
        throw jsonDecode(res.body)['message'];
      }

      // return res as List<TagihanLocalModel>;

      List<TagihanLocalModel> tagihanLocal = List<TagihanLocalModel>.from(
          jsonDecode(res.body)['data']
              .map((tagihan) => TagihanLocalModel.fromJson(tagihan))).toList();

      if (tagihanLocal.isNotEmpty) {
        deleteAllTagihan();
        final storeDb =
            tagihanLocal.map((item) async => await storeTagihan(item));
        print({"is_stored": storeDb});
      }

      return tagihanLocal;
    } catch (e) {
      rethrow;
    }
  }
}
