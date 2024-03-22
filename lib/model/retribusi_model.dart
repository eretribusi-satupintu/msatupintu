class RetribusiModel {
  final int? id;
  final String? name;
  final String? kedinasanName;
  final int? itemRetribusiTotal;

  const RetribusiModel({
    this.id,
    this.name,
    this.kedinasanName,
    this.itemRetribusiTotal,
  });

  factory RetribusiModel.fromJson(Map<String, dynamic> json) => RetribusiModel(
        id: json['id'],
        name: json['nama_retribusi'],
        kedinasanName: json['nama_kedinasan'],
        itemRetribusiTotal: json['jumlah_item_retribusi'],
      );
}
