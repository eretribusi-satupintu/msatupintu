class TagihanManualFormModel {
  final int? itemRetribusiId;
  final String? detailTagihan;
  final int? price;

  const TagihanManualFormModel(
      {this.itemRetribusiId, this.detailTagihan, this.price});

  factory TagihanManualFormModel.fromJson(Map<String, dynamic> json) =>
      TagihanManualFormModel(
        itemRetribusiId: json['item_retribusi_id'],
        detailTagihan: json['detail_tagihan'],
        price: json['total_harga'],
      );
}
