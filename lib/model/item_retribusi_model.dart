class ItemRetribusiModel {
  final int? id;
  final int? retribusiId;
  final String? categoryName;
  final String? billType;
  final int? price;

  const ItemRetribusiModel(
      {this.id,
      this.retribusiId,
      this.categoryName,
      this.billType,
      this.price});

  factory ItemRetribusiModel.fromJson(Map<String, dynamic> json) =>
      ItemRetribusiModel(
        id: json['id'],
        retribusiId: json['retribusi_id'],
        categoryName: json['kategori_nama'],
        billType: json['jenis_tagihan'],
        price: json['harga'],
      );
}
