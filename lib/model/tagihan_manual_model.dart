class TagihanManualModel {
  final int? id;
  final String? itemRetribusi;
  final String? detailTagihan;
  final String? petugas;
  final String? subwilayah;
  final int? price;
  final String? paymentMethod;
  final String? paymentImage;
  final String? status;
  final String? paidAt;
  final String? createdAt;

  const TagihanManualModel(
      {this.id,
      this.itemRetribusi,
      this.detailTagihan,
      this.petugas,
      this.subwilayah,
      this.price,
      this.paymentMethod,
      this.paymentImage,
      this.status,
      this.paidAt,
      this.createdAt});

  factory TagihanManualModel.fromJson(Map<String, dynamic> json) =>
      TagihanManualModel(
        id: json['id'],
        itemRetribusi: json['item_retribusi']['kategori_nama'],
        detailTagihan: json['detail_tagihan'],
        petugas: json['petugas']['users']['name'],
        subwilayah: json['subwilayah']['nama'],
        price: json['total_harga'],
        paymentMethod: json['metode_pembayaran'],
        paymentImage: json['bukti_bayar'],
        status: json['status'],
        paidAt: json['paid_at'],
        createdAt: json['created_at'],
      );
}
