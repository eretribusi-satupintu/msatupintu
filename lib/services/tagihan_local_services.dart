import 'dart:convert';

import 'package:satupintu_app/db/database.dart';
import 'package:satupintu_app/model/tagihan_local_amount_model.dart';
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

  Future<void> paymentConfirmationTagihan(int id, int status) async {
    try {
      final db = await dbProvider.database;
      final updateTagihan = db.update(tagihanTable, {'status': status},
          where: 'tagihan_id = ?', whereArgs: [id]);
      print({"update status": updateTagihan});
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateTagihan(TagihanLocalModel tagihan) async {
    try {
      final petugasId = AuthService().getRoleId();
      final db = await dbProvider.database;
      final updateTagihan = await db.update(
        tagihanTable,
        tagihan.toDatabaseJson(),
        where: 'tagihan_id = ?',
        whereArgs: [tagihan.tagihanId],
      );

      print({"paid": updateTagihan});
    } catch (e) {
      print({"updated_error": e.toString()});
      rethrow;
    }
  }

  Future<void> deleteTagihan(int id) async {
    try {
      final db = await dbProvider.database;
      db.delete(tagihanTable, where: 'tagihan_id = $id');
      db.close();
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
      print("stored_berhasil");

      return res;
    } catch (e) {
      print({"stored_error": e.toString()});
      rethrow;
    }
  }

  Future<TagihanLocalAmountModel> getBillAmountTagihan() async {
    try {
      final db = await dbProvider.database;
      List<Map<String, dynamic>> res = await db.rawQuery(
          'SELECT SUM(price)  as sum FROM $tagihanTable WHERE status = 1');

      if (res[0]['sum'] != null) {
        int sum = res[0]['sum'];
        List<Map<String, dynamic>> idResult = await db
            .rawQuery('SELECT tagihan_id FROM $tagihanTable WHERE status = 1');
        List<int> ids = idResult.map<int>((map) => map['tagihan_id']).toList();

        // Close database

        return TagihanLocalAmountModel(tagihanLocalId: ids, amount: sum);
      }
      return TagihanLocalAmountModel(tagihanLocalId: [], amount: 0);
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

      List<TagihanLocalModel> paidTagihanLocal = await getTagihan();
      if (paidTagihanLocal.isNotEmpty) {
        List<int?> paidTagihanIDs = paidTagihanLocal
            .where((tagihan) => tagihan.status == true)
            .map((tagihan) => tagihan.tagihanId)
            .toList();

        List<int?> unpaidTagihanIDs = paidTagihanLocal
            .where((tagihan) => tagihan.status == false)
            .map((tagihan) => tagihan.tagihanId)
            .toList();
        print({"unpaid": unpaidTagihanIDs, "padi": paidTagihanIDs});

        List<TagihanLocalModel> tagihanFromServer =
            List<TagihanLocalModel>.from(jsonDecode(res.body)['data']
                .map((tagihan) => TagihanLocalModel.fromJson(tagihan))
                .where((tagihan) =>
                    !paidTagihanIDs.contains(tagihan.tagihanId))).toList();

        if (tagihanFromServer.isNotEmpty) {
          for (var item in tagihanFromServer) {
            if (unpaidTagihanIDs.contains(item.tagihanId)) {
              await updateTagihan(item);
            } else {
              await storeTagihan(item);
            }
          }
        }

        return tagihanFromServer;
      }

      // print({"current_id": unpaidTagihanIDs});

      List<TagihanLocalModel> tagihanFromServer = List<TagihanLocalModel>.from(
          jsonDecode(res.body)['data']
              .map((tagihan) => TagihanLocalModel.fromJson(tagihan))).toList();

      if (tagihanFromServer.isNotEmpty) {
        deleteAllTagihan();
        final storeDb =
            tagihanFromServer.map((item) async => await storeTagihan(item));
        print({"is_stored": storeDb});
      }

      return tagihanFromServer;
    } catch (e) {
      rethrow;
    }
  }
}
