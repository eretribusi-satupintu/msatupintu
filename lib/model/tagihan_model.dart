class TagihanModel {
  final int? kontrakId;
  final String? nama;
  final String? totalHarga;
  final String? status;

  TagihanModel({
    this.kontrakId,
    this.nama,
    this.totalHarga,
    this.status,
  });

  factory TagihanModel.fromJson(Map<String, dynamic> json) => TagihanModel(
      kontrakId: json['kontrak_id'],
      nama: json['nama'],
      totalHarga: json['total_harga'],
      status: json['status']);
}
