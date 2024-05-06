import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:satupintu_app/model/bill_amount_model.dart';
import 'package:satupintu_app/services/auth_services.dart';
import 'package:http/http.dart' as http;
import 'package:satupintu_app/services/subwilayah_services.dart';
import 'package:satupintu_app/shared/values.dart';

class PetugasService {
  Future<BillAmountModel> getBillAmount() async {
    try {
      final token = await AuthService().getToken();
      final petugasId = await AuthService().getRoleId();
      final subwilayah =
          await SubWilayahService().getSubwilayahFromLocalStorage();
      final res = await http.get(
          Uri.parse(
              '$baseUrl/transaksi-petugas/petugas/$petugasId/sub-wilayah/${subwilayah.id}'),
          headers: {'Accept': 'application/json', 'Authorization': token});

      if (res.statusCode != 200) {
        throw jsonDecode(res.body)['message'];
      }
      // storeBillAmountToLocal(jsonDecode(res.body)['data']['total']);
      // print(jsonDecode(res.body)['data']);
      final transaksiPetugas = List<TransaksiPetugasModel>.from(
          jsonDecode(res.body)['data']['transaksi_petugas'].map(
              (transaksiPetugas) =>
                  TransaksiPetugasModel.fromJson(transaksiPetugas))).toList();

      final tagihanManual = List<TagihanManualModel>.from(
          jsonDecode(res.body)['data']['tagihan_manual']
              .map((tagihan) => TagihanManualModel.fromJson(tagihan))).toList();

      return BillAmountModel(
          transaksiPetugas: transaksiPetugas,
          total: jsonDecode(res.body)['data']['total'],
          tagihanManual: tagihanManual,
          totalTagihanManual: jsonDecode(res.body)['data']
              ['total_tagihan_manual']);
    } catch (e) {
      rethrow;
    }
  }

  // Future<TagihanUpdateModel> petugasPaidTagihan(int tagihanId) async {
  //   try {
  //     final token = await AuthService().getToken();
  //     final petugasId = await AuthService().getRoleId();
  //     final body = {
  //       "petugas_id": int.parse(petugasId),
  //       "tagihan_id": tagihanId
  //     };

  //     final res = await http.post(
  //       Uri.parse('$baseUrl/transaksi-petugas/pay/cash'),
  //       headers: {'Content-Type': 'application/json', 'Authorization': token},
  //       body: jsonEncode(body),
  //     );
  //     print(petugasId);
  //     if (res.statusCode != 200) {
  //       throw jsonDecode(res.body)['message'];
  //     }
  //     return jsonDecode(res.body)['data'];
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  Future<void> storeBillAmountToLocal(int amount) async {
    try {
      const storage = FlutterSecureStorage();
      await storage.write(key: 'billAmount', value: amount.toString());
    } catch (e) {
      rethrow;
    }
  }
}
