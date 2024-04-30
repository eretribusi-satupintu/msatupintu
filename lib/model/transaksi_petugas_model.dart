class TransaksiPetugasModel {
  final int? id;
  final int? petugasId;
  final int? tagihanId;
  final bool? disetor;

  const TransaksiPetugasModel(
      {this.id, this.petugasId, this.tagihanId, this.disetor});

  factory TransaksiPetugasModel.fromJson(Map<String, dynamic> json) =>
      TransaksiPetugasModel(
          id: json["id"],
          petugasId: json['petugas_id'],
          tagihanId: json['tagihan_id'],
          disetor: json['disetor']);
}
