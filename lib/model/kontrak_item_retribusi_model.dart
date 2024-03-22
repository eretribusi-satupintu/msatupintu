class KontrakItemRetribusiModel {
  final int? id;
  final String? status;
  final int? itemRetribusiId;
  final String? categoryName;
  final String? billType;
  final int? billTotal;
  final String? kedinasanName;

  const KontrakItemRetribusiModel(
      {this.id,
      this.status,
      this.itemRetribusiId,
      this.categoryName,
      this.billType,
      this.billTotal,
      this.kedinasanName});

  factory KontrakItemRetribusiModel.fromJson(Map<String, dynamic> json) =>
      KontrakItemRetribusiModel(
        id: json['id'],
        status: json['status'],
        itemRetribusiId: json['item_retribusi']['id'],
        categoryName: json['item_retribusi']['kategori_nama'],
        billType: json['item_retribusi']['jenis_tagihan'],
        billTotal: json['_count']['tagihan'],
        kedinasanName: json['item_retribusi']['retribusi']['kedinasan']['nama'],
      );
}
