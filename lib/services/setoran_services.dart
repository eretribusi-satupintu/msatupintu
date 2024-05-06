import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:satupintu_app/model/setoran_form_model.dart';
import 'package:satupintu_app/model/setoran_model.dart';
import 'package:satupintu_app/services/auth_services.dart';
import 'package:satupintu_app/services/subwilayah_services.dart';
import 'package:satupintu_app/shared/values.dart';

class SetoranServices {
  Future<List<SetoranModel>> getSetoran() async {
    try {
      final token = await AuthService().getToken();
      final petugasId = await AuthService().getRoleId();
      final subwilayah =
          await SubWilayahService().getSubwilayahFromLocalStorage();
      final res = await http.get(
          Uri.parse(
              '$baseUrl/setoran/petugas/$petugasId/subwilayah/${subwilayah.id}'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': token
          });

      if (res.statusCode != 200) {
        throw jsonDecode(res.body)['message'];
      }

      return List<SetoranModel>.from(jsonDecode(res.body)['data']
          .map((setoran) => SetoranModel.fromJson(setoran))).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<SetoranModel> postSetoran(SetoranFormModel setoran) async {
    try {
      final token = await AuthService().getToken();
      final petugasId = await AuthService().getRoleId();
      final subwilayah =
          await SubWilayahService().getSubwilayahFromLocalStorage();

      // late List<Map<String, dynamic>> transaksiPetugasJson;
      // setoran.transaksiPetugasId!.map((item) => transaksiPetugasJson.).toList();

      final transaksiPetugasIds =
          setoran.transaksiPetugasId!.map((tp) => tp.id).toList();
      final tagihanManualIds =
          setoran.tagihanManualId!.map((tp) => tp.id).toList();
      final body = {
        "transaksi_petugas": transaksiPetugasIds,
        "tagihan_manual": tagihanManualIds,
        "waktu_penyetoran": setoran.waktuSetoran,
        "total": setoran.total,
        "lokasi_penyetoran": setoran.lokasiPenyetoran,
        "bukti_penyetoran": setoran.buktiPenyetoran,
        "keterangan": setoran.keterangan ?? ''
      };
      print(body);
      final res = await http.post(
          Uri.parse(
              '$baseUrl/setoran/petugas/$petugasId/subwilayah/${subwilayah.id}'),
          headers: {'Content-Type': 'application/json', 'Authorization': token},
          body: jsonEncode(body));

      if (res.statusCode != 200) {
        throw jsonDecode(res.body)['message'];
      }
      return SetoranModel.fromJson(jsonDecode(res.body)['data']);
    } catch (e) {
      rethrow;
    }
  }

  Future<SetoranModel> updateSetoran(
      int setoranId, SetoranFormModel setoran) async {
    try {
      final token = await AuthService().getToken();
      final petugasId = await AuthService().getRoleId();
      final subwilayah =
          await SubWilayahService().getSubwilayahFromLocalStorage();
      final body = {
        "waktu_penyetoran": setoran.waktuSetoran,
        "total": setoran.total,
        "lokasi_penyetoran": setoran.lokasiPenyetoran,
        "bukti_penyetoran": setoran.buktiPenyetoran,
        "keterangan": setoran.keterangan ?? ''
      };
      final res = await http.put(
          Uri.parse(
              '$baseUrl/setoran/$setoranId/petugas/$petugasId/subwilayah/${subwilayah.id}'),
          headers: {'Content-Type': 'application/json', 'Authorization': token},
          body: jsonEncode(body));
      print(body);

      if (res.statusCode != 200) {
        throw jsonDecode(res.body)['message'];
      }
      print(jsonDecode(res.body)['data']);
      return SetoranModel.fromJson(jsonDecode(res.body)['data']);
    } catch (e) {
      rethrow;
    }
  }
}
