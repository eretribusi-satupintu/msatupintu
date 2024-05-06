class BillAmountModel {
  final List<TransaksiPetugasModel> transaksiPetugas;
  final int total;
  final List<TagihanManualModel> tagihanManual;
  final int totalTagihanManual;

  BillAmountModel({
    required this.transaksiPetugas,
    required this.total,
    required this.tagihanManual,
    required this.totalTagihanManual,
  });

  factory BillAmountModel.fromJson(Map<String, dynamic> json) =>
      BillAmountModel(
          transaksiPetugas: json['transaksi_petugas'],
          total: json['total'],
          tagihanManual: json['tagihan_petugas_manual'],
          totalTagihanManual: json['total_tagihan_manual']);
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

class TagihanManualModel {
  final int? id;
  final int? nominal;

  TagihanManualModel({required this.id, required this.nominal});

  factory TagihanManualModel.fromJson(Map<String, dynamic> json) {
    return TagihanManualModel(
      id: json['id'],
      nominal: json['total_harga'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "nominal": nominal,
    };
  }
}
