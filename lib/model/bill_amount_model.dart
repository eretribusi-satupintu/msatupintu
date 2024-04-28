class BillAmountModel {
  final List<TransaksiPetugasModel> transaksiPetugas;
  final int total;

  BillAmountModel({required this.transaksiPetugas, required this.total});

  factory BillAmountModel.fromJson(Map<String, dynamic> json) =>
      BillAmountModel(
          transaksiPetugas: json['transaksi_petugas'], total: json['total']);
}

class TransaksiPetugasModel {
  final int? id;
  final int? nominal;

  TransaksiPetugasModel({required this.id, required this.nominal});

  factory TransaksiPetugasModel.fromJson(Map<String, dynamic> json) {
    return TransaksiPetugasModel(
      id: json['id'],
      nominal: json['nominal'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "nominal": nominal,
    };
  }
}
