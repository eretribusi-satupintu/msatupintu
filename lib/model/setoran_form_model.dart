import 'dart:ffi';

import 'package:image_picker/image_picker.dart';

class SetoranFormModel {
  final String? waktuSetoran;
  final int? total;
  final String? lokasiPenyetoran;
  final String? buktiPenyetoran;
  final String? keterangan;

  const SetoranFormModel(this.waktuSetoran, this.total, this.lokasiPenyetoran,
      this.buktiPenyetoran, this.keterangan);

  Map<String, dynamic> toJson() {
    return {
      "waktu_penyetoran": waktuSetoran,
      "total": total,
      "lokasi_penyetoran": lokasiPenyetoran,
      "bukti_penyetoran": buktiPenyetoran,
      "keterangan": keterangan ?? '',
    };
  }
}
