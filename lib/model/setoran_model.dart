class SetoranModel {
  final int? id;
  final int? total;
  final String? waktuSetoran;
  final String? buktiSetoran;
  final String? lokasiSetoran;
  final String? keterangan;
  final String? status;

  const SetoranModel({
    this.id,
    this.total,
    this.waktuSetoran,
    this.buktiSetoran,
    this.lokasiSetoran,
    this.keterangan,
    this.status,
  });

  factory SetoranModel.fromJson(Map<String, dynamic> json) => SetoranModel(
      id: json['id'],
      total: json['total'],
      waktuSetoran: json['waktu_penyetoran'],
      buktiSetoran: json['bukti_penyetoran'],
      lokasiSetoran: json['lokasi_penyetoran'],
      keterangan: json['keterangan'] ?? '',
      status: json['status']);

  SetoranModel copyWith({
    int? total,
    String? waktuSetoran,
    String? buktiSetoran,
    String? lokasiSetoran,
    String? keterangan,
    String? status,
  }) =>
      SetoranModel(
        id: id,
        total: total ?? this.total,
        waktuSetoran: waktuSetoran ?? this.waktuSetoran,
        buktiSetoran: buktiSetoran ?? this.buktiSetoran,
        lokasiSetoran: lokasiSetoran ?? this.lokasiSetoran,
        keterangan: keterangan ?? this.keterangan,
        status: status ?? this.status,
      );
}
