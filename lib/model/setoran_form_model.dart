import 'package:satupintu_app/model/bill_amount_model.dart';

class SetoranFormModel {
  final String? waktuSetoran;
  final List<TransaksiPetugasModel>? transaksiPetugasId;
  final int? total;
  final String? lokasiPenyetoran;
  final String? buktiPenyetoran;
  final String? keterangan;

  const SetoranFormModel(
    this.waktuSetoran,
    this.transaksiPetugasId,
    this.total,
    this.lokasiPenyetoran,
    this.buktiPenyetoran,
    this.keterangan,
  );

  Map<String, dynamic> toJson() {
    return {
      "waktu_penyetoran": waktuSetoran,
      "transaksi_petugas_id": transaksiPetugasId,
      "total": total,
      "lokasi_penyetoran": lokasiPenyetoran,
      "bukti_penyetoran": buktiPenyetoran,
      "keterangan": keterangan ?? '',
    };
  }
}
